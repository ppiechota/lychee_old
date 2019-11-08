defmodule Lychee.Repo.Migrations.CreateScheduleTable do
  use Ecto.Migration

  def change do
    create table(:schedule) do
      add(:schedule_id, :string)
      add(:item_id, references(:items))
      add(:user_id, references(:users))
      add(:schedule_date, :date)
      timestamps()
    end
  end
end
