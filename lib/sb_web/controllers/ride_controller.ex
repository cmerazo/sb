defmodule SbWeb.RideController do
  use SbWeb, :controller

  alias Sb.Cases
  alias Sb.Cases.Ride

  action_fallback SbWeb.FallbackController

  def index(conn, _params) do
    rides = Cases.list_rides()
    render(conn, "index.json", rides: rides)
  end

  def create(conn, %{"ride" => ride_params}) do
    code = ride_params["promotion_code"]
    case Cases.get_promotion_by_code!(code) do
      promotion ->
        current = NaiveDateTime.utc_now()
        diff = NaiveDateTime.diff(promotion.expiration, current)

        if (diff > 0) do
          conn
          |> put_status(:not_found)
          |> render("expired_promotion.json", code: code)
        else
          event = Cases.get_event!(promotion.event_id)

          points = [[event.poligon_p1_lat,event.poligon_p1_lng],
                     [event.poligon_p1_lat,event.poligon_p1_lng],
                      [event.poligon_p1_lat,event.poligon_p1_lng],
                       [event.poligon_p1_lat,event.poligon_p1_lng]]

          in_range_ori = close_to(0,3,ride_params["origin_lat"],ride_params["origin_lng"],points)
          in_range_dest = close_to(0,3,ride_params["dest_lat"],ride_params["dest_lng"],points)

          if (in_range_ori == false && in_range_dest == false) do
            conn
            |> put_status(:not_found)
            |> render("range_failed.json", code: code)
          else
            case GoogleMaps.directions("#{Float.to_string(ride_params["origin_lat"])},#{Float.to_string(ride_params["origin_lng"])}","#{Float.to_string(ride_params["dest_lat"])},#{Float.to_string(ride_params["dest_lng"])}", key: "AIzaSyAGi2DzC-UBYivHrYwejfe0CNCJOmhukxM") do
                {:ok, result} ->
                  params = %{ammount: promotion.ammount,location_initial_lat: ride_params["origin_lat"],location_initial_lng: ride_params["origin_lng"], location_final_lat: ride_params["dest_lat"], location_final_lng: ride_params["dest_lng"], when: current, promotion_id: promotion.id}

                  with {:ok, %Ride{} = ride} <- Cases.create_ride(params) do
                    conn
                    |> put_status(:created)
                    |> put_resp_header("location", Routes.ride_path(conn, :show, ride))
                    |> render("ride_p.json", ride: ride, poliline: result["routes"])
                  end
                {:error, e_code, e_msg} ->
                  conn
                  |> put_status(:not_found)
                  |> render("google_error.json", code: e_code, message: e_msg)
            end
          end
        end
      _ ->
        conn
        |> put_status(:not_found)
        |> render("not_found_promotion.json", code: code)
    end

  end

  def show(conn, %{"id" => id}) do
    ride = Cases.get_ride!(id)
    render(conn, "show.json", ride: ride)
  end

  def update(conn, %{"id" => id, "ride" => ride_params}) do
    ride = Cases.get_ride!(id)

    with {:ok, %Ride{} = ride} <- Cases.update_ride(ride, ride_params) do
      render(conn, "show.json", ride: ride)
    end
  end

  def delete(conn, %{"id" => id}) do
    ride = Cases.get_ride!(id)

    with {:ok, %Ride{}} <- Cases.delete_ride(ride) do
      send_resp(conn, :no_content, "")
    end
  end


    def close_to(3, j, pos_lat, pos_lon, points) do
      false
    end

    def close_to(n, j, pos_lat, pos_lon, points) do

    if ( (Enum.at(Enum.at(points,n),0) > pos_lat ) != (Enum.at(Enum.at(points,j),1) > pos_lat) and
           (pos_lon < (Enum.at(Enum.at(points,j),1) - Enum.at(Enum.at(points,n),1)) *
             (pos_lat - Enum.at(Enum.at(points,n),0) ) /
               (Enum.at(Enum.at(points,j),0) - Enum.at(Enum.at(points,n),0)) + Enum.at(Enum.at(points,n),1)) ) do
        true
      else
        close_to(n + 1, n, pos_lat, pos_lon, points)
      end
    end


end
