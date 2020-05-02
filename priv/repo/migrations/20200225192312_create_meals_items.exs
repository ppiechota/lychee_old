defmodule Lychee.Repo.Migrations.CreateMealsItems do
  use Ecto.Migration

  def change do
    create table(:meals_items) do
      add(:meal_id, references(:meals))
      add(:item_id, references(:items))
      add(:weight, :decimal)
      timestamps()
    end

    create unique_index(:meals_items, [:meal_id, :item_id], name: :meals_items_ak)
  end
end
