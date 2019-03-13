defmodule SbWeb.RideControllerTest do
  use SbWeb.ConnCase

  alias Sb.Cases
  alias Sb.Cases.Ride

  @create_attrs %{
    ammount: 120.5,
    location_final_lat: 120.5,
    location_final_lng: 120.5,
    location_initial_lat: 120.5,
    location_initial_lng: 120.5,
    when: ~N[2010-04-17 14:00:00]
  }
  @update_attrs %{
    ammount: 456.7,
    location_final_lat: 456.7,
    location_final_lng: 456.7,
    location_initial_lat: 456.7,
    location_initial_lng: 456.7,
    when: ~N[2011-05-18 15:01:01]
  }
  @invalid_attrs %{ammount: nil, location_final_lat: nil, location_final_lng: nil, location_initial_lat: nil, location_initial_lng: nil, when: nil}

  def fixture(:ride) do
    {:ok, ride} = Cases.create_ride(@create_attrs)
    ride
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all rides", %{conn: conn} do
      conn = get(conn, Routes.ride_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ride" do
    test "renders ride when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ride_path(conn, :create), ride: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.ride_path(conn, :show, id))

      assert %{
               "id" => id,
               "ammount" => 120.5,
               "location_final_lat" => 120.5,
               "location_final_lng" => 120.5,
               "location_initial_lat" => 120.5,
               "location_initial_lng" => 120.5,
               "when" => "2010-04-17T14:00:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ride_path(conn, :create), ride: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ride" do
    setup [:create_ride]

    test "renders ride when data is valid", %{conn: conn, ride: %Ride{id: id} = ride} do
      conn = put(conn, Routes.ride_path(conn, :update, ride), ride: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.ride_path(conn, :show, id))

      assert %{
               "id" => id,
               "ammount" => 456.7,
               "location_final_lat" => 456.7,
               "location_final_lng" => 456.7,
               "location_initial_lat" => 456.7,
               "location_initial_lng" => 456.7,
               "when" => "2011-05-18T15:01:01"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, ride: ride} do
      conn = put(conn, Routes.ride_path(conn, :update, ride), ride: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ride" do
    setup [:create_ride]

    test "deletes chosen ride", %{conn: conn, ride: ride} do
      conn = delete(conn, Routes.ride_path(conn, :delete, ride))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.ride_path(conn, :show, ride))
      end
    end
  end

  defp create_ride(_) do
    ride = fixture(:ride)
    {:ok, ride: ride}
  end
end
