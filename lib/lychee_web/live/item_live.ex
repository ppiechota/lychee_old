defmodule LycheeWeb.ItemLive do
  use Phoenix.LiveView
  alias LycheeWeb.Router.Helpers, as: Routes
  alias LycheeWeb.ScheduleView
  require IEx

  def mount(%{schedule_id: schedule_id, user_id: user_id}, socket) do
    items = Lychee.search_items("")

    {:ok, assign(socket, items: items, schedule_id: schedule_id, user_id: user_id)}
  end

  def handle_event("search", %{"search" => %{"phrase" => phrase}}, socket) do
    items = Lychee.search_items(phrase)

    {:noreply, assign(socket, items: items)}
  end

  def handle_event(
        "add_item",
        %{"item_id" => item_id, "schedule_id" => schedule_id, "user_id" => user_id},
        socket
      ) do
    Lychee.add_item_to_schedule(item_id, schedule_id, user_id)

    schedule_path =
      Routes.schedule_path(
        socket,
        :show,
        curr_date_str()
      )

    {:stop, socket |> redirect(to: schedule_path)}
  end

  def render(assigns) do
    ScheduleView.render("items.html", assigns)
  end

  defp curr_date_str do
    Date.utc_today() |> Date.to_string()
  end
end
