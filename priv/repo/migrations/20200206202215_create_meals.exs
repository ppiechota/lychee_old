defmodule Lychee.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add(:meal_name, :string, size: 100)
      add(:user_id, references(:users))
      timestamps()
    end

    create table(:ingredients) do
      add(:meal_id, references(:meals))
      add(:item_id, references(:items))
      add(:weight, :decimal)
      timestamps()
    end

    create unique_index(:ingredients, [:meal_id, :item_id], name: :ingredients_ak)
  end
end
