defmodule Sb.Cases do
  @moduledoc """
  The Cases context.
  """

  import Ecto.Query, warn: false
  alias Sb.Repo

  alias Sb.Cases.Client

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]

  """
  def list_clients do
    Repo.all(Client)
  end

  @doc """
  Gets a single client.

  Raises `Ecto.NoResultsError` if the Client does not exist.

  ## Examples

      iex> get_client!(123)
      %Client{}

      iex> get_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_client!(id), do: Repo.get!(Client, id)

  @doc """
  Creates a client.

  ## Examples

      iex> create_client(%{field: value})
      {:ok, %Client{}}

      iex> create_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_client(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a client.

  ## Examples

      iex> update_client(client, %{field: new_value})
      {:ok, %Client{}}

      iex> update_client(client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_client(%Client{} = client, attrs) do
    client
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Client.

  ## Examples

      iex> delete_client(client)
      {:ok, %Client{}}

      iex> delete_client(client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_client(%Client{} = client) do
    Repo.delete(client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking client changes.

  ## Examples

      iex> change_client(client)
      %Ecto.Changeset{source: %Client{}}

  """
  def change_client(%Client{} = client) do
    Client.changeset(client, %{})
  end

  alias Sb.Cases.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  alias Sb.Cases.Promotion

  @doc """
  Returns the list of promotions.

  ## Examples

      iex> list_promotions()
      [%Promotion{}, ...]

  """
  def list_promotions do
    Repo.all(Promotion)
  end

  @doc """
  Returns the list of promotions.

  ## Examples

      iex> list_promotions()
      [%Promotion{}, ...]

  """
  def list_promotions_by_state(state) do
    Repo.all(from(p in Promotion, where: p.state == ^state))
  end

  @doc """
  Gets a single promotion.

  Raises `Ecto.NoResultsError` if the Promotion does not exist.

  ## Examples

      iex> get_promotion!(123)
      %Promotion{}

      iex> get_promotion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_promotion!(id), do: Repo.get!(Promotion, id)

  @doc """
  Gets a single promotion by code.

  Raises `Ecto.NoResultsError` if the Promotion does not exist.

  ## Examples

      iex> get_promotion_by_code!("")
      %Promotion{}

      iex> get_promotion_by_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_promotion_by_code!(code) do
    Repo.one!(from p in Promotion, where: p.code == ^code)
  end

  @doc """
  Creates a promotion.

  ## Examples

      iex> create_promotion(%{field: value})
      {:ok, %Promotion{}}

      iex> create_promotion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_promotion(attrs \\ %{}) do
    %Promotion{}
    |> Promotion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a promotion.

  ## Examples

      iex> update_promotion(promotion, %{field: new_value})
      {:ok, %Promotion{}}

      iex> update_promotion(promotion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_promotion(%Promotion{} = promotion, attrs) do
    promotion
    |> Promotion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Promotion.

  ## Examples

      iex> delete_promotion(promotion)
      {:ok, %Promotion{}}

      iex> delete_promotion(promotion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_promotion(%Promotion{} = promotion) do
    Repo.delete(promotion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking promotion changes.

  ## Examples

      iex> change_promotion(promotion)
      %Ecto.Changeset{source: %Promotion{}}

  """
  def change_promotion(%Promotion{} = promotion) do
    Promotion.changeset(promotion, %{})
  end

  alias Sb.Cases.Ride

  @doc """
  Returns the list of rides.

  ## Examples

      iex> list_rides()
      [%Ride{}, ...]

  """
  def list_rides do
    Repo.all(Ride)
  end

  @doc """
  Gets a single ride.

  Raises `Ecto.NoResultsError` if the Ride does not exist.

  ## Examples

      iex> get_ride!(123)
      %Ride{}

      iex> get_ride!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ride!(id), do: Repo.get!(Ride, id)

  @doc """
  Creates a ride.

  ## Examples

      iex> create_ride(%{field: value})
      {:ok, %Ride{}}

      iex> create_ride(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ride(attrs \\ %{}) do
    %Ride{}
    |> Ride.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ride.

  ## Examples

      iex> update_ride(ride, %{field: new_value})
      {:ok, %Ride{}}

      iex> update_ride(ride, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ride(%Ride{} = ride, attrs) do
    ride
    |> Ride.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ride.

  ## Examples

      iex> delete_ride(ride)
      {:ok, %Ride{}}

      iex> delete_ride(ride)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ride(%Ride{} = ride) do
    Repo.delete(ride)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ride changes.

  ## Examples

      iex> change_ride(ride)
      %Ecto.Changeset{source: %Ride{}}

  """
  def change_ride(%Ride{} = ride) do
    Ride.changeset(ride, %{})
  end
end
