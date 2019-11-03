defmodule Lychee do
  import Ecto.Query
  alias Lychee.{User, Password, Item}
  @repo Lychee.Repo

  def search_items(name) do
    query =
      from(a in Item,
        where: a.name == ^name
      )

    @repo.all(query)
  end

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
