defmodule LycheeWeb.ScheduleController do
  use LycheeWeb, :controller

  def show(conn, %{"id" => id}) do
    meals = Lychee.get_schedule_meals(id)
    render(conn, "show.html", id: id, meals: meals)
  end

  def edit(conn, %{"id" => id}) do
    live_render(conn, LycheeWeb.ItemLive,
      session: %{schedule_id: id, user_id: conn.assigns.current_user.id}
    )
  end

  def delete(conn, %{"id" => schedule_id, "meal_id" => meal_id}) do
    Lychee.delete_meal_from_schedule(schedule_id, meal_id)

    conn |> redirect(to: Routes.schedule_path(conn, :show, schedule_id))
  end
end
