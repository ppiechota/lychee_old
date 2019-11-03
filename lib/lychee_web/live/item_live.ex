defmodule LycheeWeb.ItemLive do
  use Phoenix.LiveView
  alias LycheeWeb.ScheduleView

  def mount(_session, socket) do
    items = Lychee.search_items("")
    {:ok, assign(socket, items: items)}
  end

  def handle_event("search", %{"search" => %{"phrase" => phrase}}, socket) do
    items = Lychee.search_items(phrase)
    {:noreply, assign(socket, items: items)}
  end

  def render(assigns) do
    ScheduleView.render("items.html", assigns)
  end
end
