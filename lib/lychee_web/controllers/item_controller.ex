defmodule LycheeWeb.ItemController do
  use LycheeWeb, :controller
  require IEx

  def index(conn, _assigns) do
    items = Lychee.get_all_items()
    render(conn, "index.html", items: items)
  end

  def new(conn, _params) do
    item = Lychee.new_item()
    render(conn, "new.html", item: item)
  end

  def edit(conn, %{"id" => id}) do
    live_render(conn, LycheeWeb.ItemLive,
      session: %{schedule_id: id, user_id: conn.assigns.current_user.id}
    )
  end

  def delete(conn, %{"id" => id}) do
    Lychee.delete_item(id)
    redirect(conn, to: Routes.item_path(conn, :index))
  end

  def create(conn, %{"item" => item_params}) do
    {:ok, _item} = Lychee.insert_item(item_params)
    redirect(conn, to: Routes.item_path(conn, :index))
  end
end
