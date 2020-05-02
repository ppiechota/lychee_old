defmodule Lychee.Meal do
  use Ecto.Schema

  schema "meals" do
    field(:meal_name, :string, size: 100)
    belongs_to(:user, Lychee.User)
    has_many(:ingredients, Lychee.Ingredient, foreign_key: :meal_id)
    timestamps()
  end

  def changeset(meal, params \\ %{}) do
    meal
    |> Ecto.Changeset.cast(params, [:meal_name, :user_id])
    |> Ecto.Changeset.validate_required(:meal_name)
    |> Ecto.Changeset.validate_required(:user_id)
  end
end
