defmodule LycheeWeb.MealLive do
  use Phoenix.LiveView
  alias LycheeWeb.Router.Helpers, as: Routes
  alias LycheeWeb.MealView
  require IEx

  def mount(%{meal_id: meal_id, user_id: user_id}, socket) do
    items = Lychee.search_items("")
    meal = Lychee.get_meal_with_ingredients(meal_id)

    {:ok, assign(socket, items: items, meal: meal, user_id: user_id)}
  end

  def handle_event("search", %{"search" => %{"phrase" => phrase}}, socket) do
    items = Lychee.search_items(phrase)

    {:noreply, assign(socket, items: items)}
  end

  def handle_event(
        "add_item",
        %{"item" => %{"id" => item_id, "weight" => weight}},
        %{assigns: %{meal: meal}} = socket
      ) do
    Lychee.insert_ingredient(%{item_id: item_id, weight: weight, meal_id: meal.id})
    meal = Lychee.get_meal_with_ingredients(meal.id)

    {:noreply, assign(socket, meal: meal)}
  end

  def handle_event(
        "delete_item",
        %{"item" => %{"id" => item_id}},
        %{assigns: %{meal: meal}} = socket
      ) do
    Lychee.delete_ingredient(meal.id, item_id)
    meal = Lychee.get_meal_with_ingredients(meal.id)

    {:noreply, assign(socket, meal: meal)}
  end

  def render(assigns) do
    MealView.render("items.html", assigns)
  end
end
