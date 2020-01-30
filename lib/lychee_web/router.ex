defmodule LycheeWeb.Router do
  use LycheeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug LycheeWeb.Authenticator
    plug :put_layout, {LycheeWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LycheeWeb do
    pipe_through :browser

    live "/", CounterLive

    get "/users", UserController, :new
    post "/users", UserController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    resources "/schedule", ScheduleController

    resources "/item", ItemController, only: [:index, :show, :edit, :new, :create, :delete]
  end
end
