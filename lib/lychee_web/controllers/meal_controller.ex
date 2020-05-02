defmodule LycheeWeb.MealController do
  use LycheeWeb, :controller
  require IEx

  def index(conn, _assigns) do
    meals = Lychee.get_all_meals()
    render(conn, "index.html", meals: meals)
  end

  def new(conn, _params) do
    meal = Lychee.new_meal()
    render(conn, "new.html", meal: meal)
  end

  def edit(conn, %{"id" => meal_id}) do
    meal = Lychee.get_meal(meal_id)
    render(conn, "edit.html", meal: meal)
  end

  def delete(conn, %{"id" => id}) do
    Lychee.delete_meal(id)
    redirect(conn, to: Routes.meal_path(conn, :index))
  end

  def create(conn, %{"meal" => meal_params}) do
    current_user = Map.get(conn.assigns, :current_user)
    {:ok, _meal} = Map.put(meal_params, "user_id", current_user.id) |> Lychee.insert_meal()
    redirect(conn, to: Routes.meal_path(conn, :index))
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    Lychee.update_item(id, item_params)
    redirect(conn, to: Routes.item_path(conn, :index))
  end
end
