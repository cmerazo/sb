defmodule Sb.Cases.Ride do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rides" do
    field :ammount, :float
    field :location_final_lat, :float
    field :location_final_lng, :float
    field :location_initial_lat, :float
    field :location_initial_lng, :float
    field :when, :naive_datetime
    belongs_to :promotion, Promotion
    # field :promotion_id, :id

    timestamps()
  end

  @doc false
  def changeset(ride, attrs) do
    ride
    |> cast(attrs, [
      :when,
      :ammount,
      :location_initial_lat,
      :location_final_lat,
      :location_initial_lng,
      :location_final_lng
    ])
    |> validate_required([
      :when,
      :ammount,
      :location_initial_lat,
      :location_final_lat,
      :location_initial_lng,
      :location_final_lng
    ])
    |> foreign_key_constraint(:promotion_id)
  end
end
