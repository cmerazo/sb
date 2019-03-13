defmodule SbWeb.ClientView do
  use SbWeb, :view
  alias SbWeb.ClientView

  def render("index.json", %{clients: clients}) do
    %{data: render_many(clients, ClientView, "client.json")}
  end

  def render("show.json", %{client: client}) do
    %{data: render_one(client, ClientView, "client.json")}
  end

  def render("client.json", %{client: client}) do
    %{
      id: client.id,
      first_name: client.first_name,
      last_name: client.last_name,
      identification: client.identification
    }
  end
end
