defmodule SbWeb.PageController do
  use SbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
