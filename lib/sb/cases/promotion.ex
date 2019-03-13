defmodule Sb.Cases.Promotion do
  use Ecto.Schema
  import Ecto.Changeset


  schema "promotions" do
    field :ammount, :float
    field :code, :string
    field :expiration, :naive_datetime
    field :state, :boolean, default: false
    field :event_id, :id
    field :client_id, :id

    timestamps()
  end

  @doc false
  def changeset(promotion, attrs) do
    promotion
    |> cast(attrs, [:code, :ammount, :expiration, :state, :client_id, :event_id])
    |> validate_required([:code, :ammount, :expiration, :state, :client_id, :event_id])
  end

  def randomizer(length, type \\ :all) do
    alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    numbers = "0123456789"

    lists =
      cond do
        type == :alpha -> alphabets <> String.downcase(alphabets)
        type == :numeric -> numbers
        type == :upcase -> alphabets
        type == :downcase -> String.downcase(alphabets)
        true -> alphabets <> String.downcase(alphabets) <> numbers
      end
      |> String.split("", trim: true)

    do_randomizer(length, lists)
  end

  @doc false
  defp get_range(length) when length > 1, do: (1..length)
  defp get_range(length), do: [1]

  @doc false
  defp do_randomizer(length, lists) do
    get_range(length)
    |> Enum.reduce([], fn(_, acc) -> [Enum.random(lists) | acc] end)
    |> Enum.join("")
  end

end
