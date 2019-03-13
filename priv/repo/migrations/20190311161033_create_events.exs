defmodule Sb.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :poligon_p1_lat, :float
      add :poligon_p2_lat, :float
      add :poligon_p3_lat, :float
      add :poligon_p4_lat, :float
      add :poligon_p1_lng, :float
      add :poligon_p2_lng, :float
      add :poligon_p3_lng, :float
      add :poligon_p4_lng, :float
      add :location_lat, :float
      add :location_lng, :float
      add :start_event, :naive_datetime
      add :end_event, :naive_datetime

      timestamps()
    end
  end
end
