defmodule Sb.Cases.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field :first_name, :string
    field :identification, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:first_name, :last_name, :identification])
    |> validate_required([:first_name, :last_name, :identification])
  end
end
