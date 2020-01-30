defmodule Lychee do
  @moduledoc """
  Lychee main interface
  """

  import Ecto.Query
  alias Lychee.{User, Password, Item, Schedule}
  @repo Lychee.Repo

  def add_item_to_schedule(item_id, schedule_id, user_id) do
    %Schedule{}
    |> Schedule.changeset(%{item_id: item_id, schedule_id: schedule_id, user_id: user_id})
    |> @repo.insert

    # TODO: error logic
  end

  @doc """
    Shows items from a provided schedule.

    ### Parameters

      - schedule_id: Number that represents the id of a schedule.
  """
  @spec get_schedule_items(number()) :: [%Item{}]

  def get_schedule_items(schedule_id) do
    query =
      from i in Item,
        join: s in Schedule,
        on: i.id == s.item_id,
        where: s.schedule_id == ^schedule_id,
        select: merge(map(i, [:name, :kcal, :proteins, :fat, :carbs]), map(s, [:id]))

    @repo.all(query)
  end

  @doc """
    Searches for an item with a `name`.

    ### Parameters

      - name: String that represents the name of an item.
  """
  @spec search_items(String.t()) :: [%Item{}]

  def search_items(name) do
    like_term = "%#{name}%"
    query = from(a in Item, where: ilike(a.name, ^like_term))
    @repo.all(query)
  end

  @doc """
    Lists all items

    ### Parameters
  """
  @spec get_all_items() :: [%Item{}]

  def get_all_items() do
    query = from(a in Item)
    @repo.all(query)
  end

  def insert_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> @repo.insert
  end

  def delete_item(item_id) do
    from(i in Item, where: i.id == ^item_id)
    |> @repo.delete_all
  end

  def delete_item_from_schedule(item_id) do
    from(s in Schedule, where: s.id == ^item_id)
    |> @repo.delete_all
  end

  def new_item, do: Item.changeset(%Item{})

  def get_user(id), do: @repo.get!(User, id)

  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> @repo.insert
  end

  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- @repo.get_by(User, %{username: username}),
         true <- Password.verify_with_hash(password, user.hashed_password) do
      user
    else
      _ -> Password.dummy_verify()
    end
  end
end
