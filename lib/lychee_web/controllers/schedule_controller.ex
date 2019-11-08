defmodule LycheeWeb.ScheduleController do
  use LycheeWeb, :controller
  require IEx

  def show(conn, %{"id" => id}) do
    items = Lychee.get_schedule_items(id)
    render(conn, "show.html", id: id, items: items)
  end

  def edit(conn, %{"id" => id}) do
    live_render(conn, LycheeWeb.ItemLive,
      session: %{schedule_id: id, user_id: conn.assigns.current_user.id}
    )
  end
end