defmodule LycheeWeb.PageController do
  use LycheeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
