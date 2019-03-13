defmodule SbWeb.EventController do
  use SbWeb, :controller

  alias Sb.Cases
  alias Sb.Cases.Event

  action_fallback SbWeb.FallbackController

  def index(conn, _params) do
    events = Cases.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Cases.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Cases.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Cases.get_event!(id)

    with {:ok, %Event{} = event} <- Cases.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Cases.get_event!(id)

    with {:ok, %Event{}} <- Cases.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
