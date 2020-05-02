defmodule Lychee.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedule" do
    field(:schedule_id, :string)
    field(:schedule_date, :date)
    belongs_to(:user, Lychee.User)
    belongs_to(:meal, Lychee.Meal)
    field(:weight, :decimal)
    timestamps()
  end

  def changeset(schedule, params \\ %{}) do
    schedule
    |> cast(params, [:meal_id, :user_id, :schedule_id])
    |> validate_required([:meal_id, :user_id, :schedule_id])
    |> assoc_constraint(:meal)
    |> assoc_constraint(:user)
  end
end
