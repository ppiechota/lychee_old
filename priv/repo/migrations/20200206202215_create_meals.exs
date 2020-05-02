defmodule Lychee.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add(:meal_name, :string, size: 100)
      add(:user_id, references(:users))
      timestamps()
    end
  end
end
