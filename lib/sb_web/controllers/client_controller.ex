defmodule SbWeb.ClientController do
  use SbWeb, :controller

  alias Sb.Cases
  alias Sb.Cases.Client

  action_fallback SbWeb.FallbackController

  def index(conn, _params) do
    clients = Cases.list_clients()
    render(conn, "index.json", clients: clients)
  end

  def create(conn, %{"client" => client_params}) do
    with {:ok, %Client{} = client} <- Cases.create_client(client_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.client_path(conn, :show, client))
      |> render("show.json", client: client)
    end
  end

  def show(conn, %{"id" => id}) do
    client = Cases.get_client!(id)
    render(conn, "show.json", client: client)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    client = Cases.get_client!(id)

    with {:ok, %Client{} = client} <- Cases.update_client(client, client_params) do
      render(conn, "show.json", client: client)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = Cases.get_client!(id)

    with {:ok, %Client{}} <- Cases.delete_client(client) do
      send_resp(conn, :no_content, "")
    end
  end
end
