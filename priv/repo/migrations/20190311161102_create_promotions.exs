defmodule Sb.Repo.Migrations.CreatePromotions do
  use Ecto.Migration

  def change do
    create table(:promotions) do
      add :code, :string
      add :ammount, :float
      add :expiration, :naive_datetime
      add :state, :boolean, default: false, null: false
      add :event_id, references(:events, on_delete: :nothing)
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps()
    end

    create index(:promotions, [:event_id])
    create index(:promotions, [:client_id])
  end
end
