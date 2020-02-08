defmodule Lychee.Ingredient do
  use Ecto.Schema

  schema "ingredients" do
    belongs_to(:meal, Lychee.Meal)
    belongs_to(:item, Lychee.Item)
    field(:weight, :decimal)
    timestamps()
  end

  def changeset(ingr, params \\ %{}) do
    ingr
    |> Ecto.Changeset.cast(params, [:meal_id, :item_id, :weight])
    |> Ecto.Changeset.validate_required(:meal_id)
    |> Ecto.Changeset.validate_required(:item_id)
    |> Ecto.Changeset.validate_required(:weight)
  end
end
