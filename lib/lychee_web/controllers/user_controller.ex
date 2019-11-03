defmodule LycheeWeb.UserController do
  use LycheeWeb, :controller
  plug :prevent_unauthorized_access when action in [:show]

  def new(conn, _params) do
    user = Lychee.new_user()
    render(conn, "new.html", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    case Lychee.insert_user(user_params) do
      {:ok, _user} -> redirect(conn, to: Routes.session_path(conn, :new))
      {:error, user} -> render(conn, "new.html", user: user)
    end
  end

  defp prevent_unauthorized_access(conn, _opts) do
    current_user = Map.get(conn.assigns, :current_user)

    requested_user_id = conn.params |> Map.get("id") |> String.to_integer()

    if current_user == nil || requested_user_id != current_user.id do
      conn
      |> put_flash(:error, "Brak dostępu")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    else
      conn
    end
  end
end
