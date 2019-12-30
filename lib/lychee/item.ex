defmodule Lychee.Item do
  use Ecto.Schema

  schema "items" do
    field(:name, :string)
    field(:kcal, :decimal)
    field(:carbs, :decimal)
    field(:proteins, :decimal)
    field(:fat, :decimal)
    timestamps()
  end

  def changeset(item, params \\ %{}) do
    item
    |> Ecto.Changeset.cast(params, [:name, :kcal, :carbs, :proteins, :fat])
    |> Ecto.Changeset.validate_required(:name)
    |> Ecto.Changeset.validate_required(:kcal)
    |> Ecto.Changeset.validate_required(:carbs)
    |> Ecto.Changeset.validate_required(:proteins)
    |> Ecto.Changeset.validate_required(:fat)
  end
end
