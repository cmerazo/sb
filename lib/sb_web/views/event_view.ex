defmodule SbWeb.EventView do
  use SbWeb, :view
  alias SbWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      name: event.name,
      poligon_p1_lat: event.poligon_p1_lat,
      poligon_p2_lat: event.poligon_p2_lat,
      poligon_p3_lat: event.poligon_p3_lat,
      poligon_p4_lat: event.poligon_p4_lat,
      poligon_p1_lng: event.poligon_p1_lng,
      poligon_p2_lng: event.poligon_p2_lng,
      poligon_p3_lng: event.poligon_p3_lng,
      poligon_p4_lng: event.poligon_p4_lng,
      location_lat: event.location_lat,
      location_lng: event.location_lng,
      start_event: event.start_event,
      end_event: event.end_event
    }
  end
end
