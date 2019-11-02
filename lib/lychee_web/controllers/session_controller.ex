defmodule LycheeWeb.SessionController do
  use LycheeWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    case Lychee.get_user_by_username_and_password(username, password) do
      %Lychee.User{} = user ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Successfully logged in")
        |> redirect(to: Routes.user_path(conn, :new))

      _ ->
        conn
        |> put_flash(:error, "That username and password combination cannot be found")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
