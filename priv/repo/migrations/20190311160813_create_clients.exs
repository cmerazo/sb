defmodule Sb.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :first_name, :string
      add :last_name, :string
      add :identification, :string

      timestamps()
    end
  end
end
