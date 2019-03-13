defmodule Sb.CasesTest do
  use Sb.DataCase

  alias Sb.Cases

  describe "clients" do
    alias Sb.Cases.Client

    @valid_attrs %{
      first_name: "some first_name",
      identification: "some identification",
      last_name: "some last_name"
    }
    @update_attrs %{
      first_name: "some updated first_name",
      identification: "some updated identification",
      last_name: "some updated last_name"
    }
    @invalid_attrs %{first_name: nil, identification: nil, last_name: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cases.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Cases.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Cases.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Cases.create_client(@valid_attrs)
      assert client.first_name == "some first_name"
      assert client.identification == "some identification"
      assert client.last_name == "some last_name"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cases.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, %Client{} = client} = Cases.update_client(client, @update_attrs)
      assert client.first_name == "some updated first_name"
      assert client.identification == "some updated identification"
      assert client.last_name == "some updated last_name"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Cases.update_client(client, @invalid_attrs)
      assert client == Cases.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Cases.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Cases.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Cases.change_client(client)
    end
  end

  describe "events" do
    alias Sb.Cases.Event

    @valid_attrs %{
      end_event: ~N[2010-04-17 14:00:00],
      location_lat: 120.5,
      location_lng: 120.5,
      name: "some name",
      poligon_p1_lat: 120.5,
      poligon_p1_lng: 120.5,
      poligon_p2_lat: 120.5,
      poligon_p2_lng: 120.5,
      poligon_p3_lat: 120.5,
      poligon_p3_lng: 120.5,
      poligon_p4_lat: 120.5,
      poligon_p4_lng: 120.5,
      start_event: ~N[2010-04-17 14:00:00]
    }
    @update_attrs %{
      end_event: ~N[2011-05-18 15:01:01],
      location_lat: 456.7,
      location_lng: 456.7,
      name: "some updated name",
      poligon_p1_lat: 456.7,
      poligon_p1_lng: 456.7,
      poligon_p2_lat: 456.7,
      poligon_p2_lng: 456.7,
      poligon_p3_lat: 456.7,
      poligon_p3_lng: 456.7,
      poligon_p4_lat: 456.7,
      poligon_p4_lng: 456.7,
      start_event: ~N[2011-05-18 15:01:01]
    }
    @invalid_attrs %{
      end_event: nil,
      location_lat: nil,
      location_lng: nil,
      name: nil,
      poligon_p1_lat: nil,
      poligon_p1_lng: nil,
      poligon_p2_lat: nil,
      poligon_p2_lng: nil,
      poligon_p3_lat: nil,
      poligon_p3_lng: nil,
      poligon_p4_lat: nil,
      poligon_p4_lng: nil,
      start_event: nil
    }

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cases.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Cases.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Cases.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Cases.create_event(@valid_attrs)
      assert event.end_event == ~N[2010-04-17 14:00:00]
      assert event.location_lat == 120.5
      assert event.location_lng == 120.5
      assert event.name == "some name"
      assert event.poligon_p1_lat == 120.5
      assert event.poligon_p1_lng == 120.5
      assert event.poligon_p2_lat == 120.5
      assert event.poligon_p2_lng == 120.5
      assert event.poligon_p3_lat == 120.5
      assert event.poligon_p3_lng == 120.5
      assert event.poligon_p4_lat == 120.5
      assert event.poligon_p4_lng == 120.5
      assert event.start_event == ~N[2010-04-17 14:00:00]
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cases.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Cases.update_event(event, @update_attrs)
      assert event.end_event == ~N[2011-05-18 15:01:01]
      assert event.location_lat == 456.7
      assert event.location_lng == 456.7
      assert event.name == "some updated name"
      assert event.poligon_p1_lat == 456.7
      assert event.poligon_p1_lng == 456.7
      assert event.poligon_p2_lat == 456.7
      assert event.poligon_p2_lng == 456.7
      assert event.poligon_p3_lat == 456.7
      assert event.poligon_p3_lng == 456.7
      assert event.poligon_p4_lat == 456.7
      assert event.poligon_p4_lng == 456.7
      assert event.start_event == ~N[2011-05-18 15:01:01]
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Cases.update_event(event, @invalid_attrs)
      assert event == Cases.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Cases.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Cases.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Cases.change_event(event)
    end
  end

  describe "promotions" do
    alias Sb.Cases.Promotion

    @valid_attrs %{
      ammount: 120.5,
      code: "some code",
      expiration: ~N[2010-04-17 14:00:00],
      state: true
    }
    @update_attrs %{
      ammount: 456.7,
      code: "some updated code",
      expiration: ~N[2011-05-18 15:01:01],
      state: false
    }
    @invalid_attrs %{ammount: nil, code: nil, expiration: nil, state: nil}

    def promotion_fixture(attrs \\ %{}) do
      {:ok, promotion} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cases.create_promotion()

      promotion
    end

    test "list_promotions/0 returns all promotions" do
      promotion = promotion_fixture()
      assert Cases.list_promotions() == [promotion]
    end

    test "get_promotion!/1 returns the promotion with given id" do
      promotion = promotion_fixture()
      assert Cases.get_promotion!(promotion.id) == promotion
    end

    test "create_promotion/1 with valid data creates a promotion" do
      assert {:ok, %Promotion{} = promotion} = Cases.create_promotion(@valid_attrs)
      assert promotion.ammount == 120.5
      assert promotion.code == "some code"
      assert promotion.expiration == ~N[2010-04-17 14:00:00]
      assert promotion.state == true
    end

    test "create_promotion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cases.create_promotion(@invalid_attrs)
    end

    test "update_promotion/2 with valid data updates the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{} = promotion} = Cases.update_promotion(promotion, @update_attrs)
      assert promotion.ammount == 456.7
      assert promotion.code == "some updated code"
      assert promotion.expiration == ~N[2011-05-18 15:01:01]
      assert promotion.state == false
    end

    test "update_promotion/2 with invalid data returns error changeset" do
      promotion = promotion_fixture()
      assert {:error, %Ecto.Changeset{}} = Cases.update_promotion(promotion, @invalid_attrs)
      assert promotion == Cases.get_promotion!(promotion.id)
    end

    test "delete_promotion/1 deletes the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{}} = Cases.delete_promotion(promotion)
      assert_raise Ecto.NoResultsError, fn -> Cases.get_promotion!(promotion.id) end
    end

    test "change_promotion/1 returns a promotion changeset" do
      promotion = promotion_fixture()
      assert %Ecto.Changeset{} = Cases.change_promotion(promotion)
    end
  end

  describe "rides" do
    alias Sb.Cases.Ride

    @valid_attrs %{
      ammount: 120.5,
      location_final_lat: 120.5,
      location_final_lng: 120.5,
      location_initial_lat: 120.5,
      location_initial_lng: 120.5,
      when: ~N[2010-04-17 14:00:00]
    }
    @update_attrs %{
      ammount: 456.7,
      location_final_lat: 456.7,
      location_final_lng: 456.7,
      location_initial_lat: 456.7,
      location_initial_lng: 456.7,
      when: ~N[2011-05-18 15:01:01]
    }
    @invalid_attrs %{
      ammount: nil,
      location_final_lat: nil,
      location_final_lng: nil,
      location_initial_lat: nil,
      location_initial_lng: nil,
      when: nil
    }

    def ride_fixture(attrs \\ %{}) do
      {:ok, ride} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cases.create_ride()

      ride
    end

    test "list_rides/0 returns all rides" do
      ride = ride_fixture()
      assert Cases.list_rides() == [ride]
    end

    test "get_ride!/1 returns the ride with given id" do
      ride = ride_fixture()
      assert Cases.get_ride!(ride.id) == ride
    end

    test "create_ride/1 with valid data creates a ride" do
      assert {:ok, %Ride{} = ride} = Cases.create_ride(@valid_attrs)
      assert ride.ammount == 120.5
      assert ride.location_final_lat == 120.5
      assert ride.location_final_lng == 120.5
      assert ride.location_initial_lat == 120.5
      assert ride.location_initial_lng == 120.5
      assert ride.when == ~N[2010-04-17 14:00:00]
    end

    test "create_ride/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cases.create_ride(@invalid_attrs)
    end

    test "update_ride/2 with valid data updates the ride" do
      ride = ride_fixture()
      assert {:ok, %Ride{} = ride} = Cases.update_ride(ride, @update_attrs)
      assert ride.ammount == 456.7
      assert ride.location_final_lat == 456.7
      assert ride.location_final_lng == 456.7
      assert ride.location_initial_lat == 456.7
      assert ride.location_initial_lng == 456.7
      assert ride.when == ~N[2011-05-18 15:01:01]
    end

    test "update_ride/2 with invalid data returns error changeset" do
      ride = ride_fixture()
      assert {:error, %Ecto.Changeset{}} = Cases.update_ride(ride, @invalid_attrs)
      assert ride == Cases.get_ride!(ride.id)
    end

    test "delete_ride/1 deletes the ride" do
      ride = ride_fixture()
      assert {:ok, %Ride{}} = Cases.delete_ride(ride)
      assert_raise Ecto.NoResultsError, fn -> Cases.get_ride!(ride.id) end
    end

    test "change_ride/1 returns a ride changeset" do
      ride = ride_fixture()
      assert %Ecto.Changeset{} = Cases.change_ride(ride)
    end
  end
end
