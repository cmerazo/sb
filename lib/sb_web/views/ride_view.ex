defmodule SbWeb.RideView do
  use SbWeb, :view
  alias SbWeb.RideView

  def render("index.json", %{rides: rides}) do
    %{data: render_many(rides, RideView, "ride.json")}
  end

  def render("show.json", %{ride: ride}) do
    %{data: render_one(ride, RideView, "ride.json")}
  end

  def render("created.json", %{ride: ride, poliline: poliline}) do
    %{data: render_one(ride, RideView, "ride_p.json")}
  end

  def render("ride.json", %{ride: ride}) do
    %{
      id: ride.id,
      when: ride.when,
      ammount: CurrencyFormatter.format(Float.to_string(ride.ammount, decimals: 2), :eur),
      location_initial_lat: ride.location_initial_lat,
      location_final_lat: ride.location_final_lat,
      location_initial_lng: ride.location_initial_lng,
      location_final_lng: ride.location_final_lng
    }
  end

  def render("ride_p.json", %{ride: ride, poliline: poliline}) do
    %{
      id: ride.id,
      when: ride.when,
      ammount: CurrencyFormatter.format(Float.to_string(ride.ammount, decimals: 2), :eur),
      location_initial_lat: ride.location_initial_lat,
      location_final_lat: ride.location_final_lat,
      location_initial_lng: ride.location_initial_lng,
      location_final_lng: ride.location_final_lng,
      poliline: poliline
    }
  end

  def render("not_found_event.json", %{code: code}) do
    %{code: 404, message: "promotion #{code} not found"}
  end

  def render("expired_promotion.json", %{code: code}) do
    %{code: 500, message: "promotion #{code} expired"}
  end

  def render("range_failed.json", %{code: code}) do
    %{code: 501, message: "the origin or destination must be in the polygon of the event range"}
  end

  def render("google_error.json", %{code: code, message: msg}) do
    %{code: 502, message: "conection gmap error #{code}, message: #{msg}"}
  end
end
