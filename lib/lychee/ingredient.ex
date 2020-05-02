defmodule Lychee.Ingredient do
  use Ecto.Schema

  @primary_key false
  schema "ingredients" do
    belongs_to(:meal, Lychee.Meal)
    belongs_to(:item, Lychee.Item)
    field(:weight, :decimal)
    field(:name, :string)
    field(:kcal, :decimal)
    field(:carbs, :decimal)
    field(:proteins, :decimal)
    field(:fat, :decimal)
  end

  def changeset(ingr, params \\ %{}) do
    ingr
    |> Ecto.Changeset.cast(params, [:meal_id, :item_id, :weight])
    |> Ecto.Changeset.validate_required([:meal_id, :item_id, :weight])
  end
end
