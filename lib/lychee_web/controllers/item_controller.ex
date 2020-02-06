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
    item = Lychee.edit_item(id)
    render(conn, "edit.html", item: item)
  end

  def delete(conn, %{"id" => id}) do
    Lychee.delete_item(id)
    redirect(conn, to: Routes.item_path(conn, :index))
  end

  def create(conn, %{"item" => item_params}) do
    {:ok, _item} = Lychee.insert_item(item_params)
    redirect(conn, to: Routes.item_path(conn, :index))
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    Lychee.update_item(id, item_params)
    redirect(conn, to: Routes.item_path(conn, :index))
  end
end
