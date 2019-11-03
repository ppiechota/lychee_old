defmodule LycheeWeb.ScheduleController do
  use LycheeWeb, :controller

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", id: id)
  end

  def edit(conn, %{"id" => id}) do
    render(conn, "edit.html", id: id)
  end
end
