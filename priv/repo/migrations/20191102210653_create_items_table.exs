defmodule Lychee.Repo.Migrations.CreateItemsTable do
  use Ecto.Migration

  def change do
    create table("items") do
      add(:name, :string)
      add(:kcal, :decimal)
      add(:carbs, :decimal)
      add(:proteins, :decimal)
      add(:fat, :decimal)
      timestamps()
    end
  end
end
