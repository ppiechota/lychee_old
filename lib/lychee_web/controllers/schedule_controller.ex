defmodule LycheeWeb.ScheduleController do
  use LycheeWeb, :controller
  require IEx

  def show(conn, %{"id" => id}) do
    items = Lychee.get_schedule_items(id)
    IEx.pry()
    render(conn, "show.html", id: id, items: items)
  end

  def edit(conn, %{"id" => id}) do
    live_render(conn, LycheeWeb.ItemLive,
      session: %{schedule_id: id, user_id: conn.assigns.current_user.id}
    )
  end

  def delete(conn, %{"id" => schedule_id, "item_id" => item_id}) do
    IEx.pry()
    Lychee.delete_item_from_schedule(item_id)

    conn |> redirect(to: Routes.schedule_path(conn, :show, schedule_id))
  end
end
