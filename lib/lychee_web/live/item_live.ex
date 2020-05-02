defmodule LycheeWeb.ItemLive do
  use Phoenix.LiveView
  alias LycheeWeb.Router.Helpers, as: Routes
  alias LycheeWeb.ScheduleView
  require IEx

  def mount(%{schedule_id: schedule_id, user_id: user_id}, socket) do
    meals = Lychee.search_meals("")

    {:ok, assign(socket, meals: meals, schedule_id: schedule_id, user_id: user_id)}
  end

  def handle_event("search", %{"search" => %{"phrase" => phrase}}, socket) do
    meals = Lychee.search_meals(phrase)

    {:noreply, assign(socket, meals: meals)}
  end

  def handle_event(
        "add_meal",
        %{"meal" => %{"id" => meal_id}},
        %{assigns: %{schedule_id: schedule_id, user_id: user_id}} = socket
      ) do
    # IEx.pry()

    Lychee.add_meal_to_schedule(meal_id, schedule_id, user_id)

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
