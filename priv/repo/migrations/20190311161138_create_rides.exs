defmodule Sb.Repo.Migrations.CreateRides do
  use Ecto.Migration

  def change do
    create table(:rides) do
      add :when, :naive_datetime
      add :ammount, :float
      add :location_initial_lat, :float
      add :location_final_lat, :float
      add :location_initial_lng, :float
      add :location_final_lng, :float
      add :promotion_id, references(:promotions, on_delete: :nothing)

      timestamps()
    end

    create index(:rides, [:promotion_id])
  end
end
