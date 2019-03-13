defmodule Sb.Cases.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :end_event, :naive_datetime
    field :location_lat, :float
    field :location_lng, :float
    field :name, :string
    field :poligon_p1_lat, :float
    field :poligon_p1_lng, :float
    field :poligon_p2_lat, :float
    field :poligon_p2_lng, :float
    field :poligon_p3_lat, :float
    field :poligon_p3_lng, :float
    field :poligon_p4_lat, :float
    field :poligon_p4_lng, :float
    field :start_event, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :poligon_p1_lat, :poligon_p2_lat, :poligon_p3_lat, :poligon_p4_lat, :poligon_p1_lng, :poligon_p2_lng, :poligon_p3_lng, :poligon_p4_lng, :location_lat, :location_lng, :start_event, :end_event])
    |> validate_required([:name, :poligon_p1_lat, :poligon_p2_lat, :poligon_p3_lat, :poligon_p4_lat, :poligon_p1_lng, :poligon_p2_lng, :poligon_p3_lng, :poligon_p4_lng, :location_lat, :location_lng, :start_event, :end_event])
  end
end
