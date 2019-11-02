# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lychee,
  ecto_repos: [Lychee.Repo]

# Configures the endpoint
config :lychee, LycheeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cRM9HXoNi/av9rKJYIsoVnOpoU6SSP8/hy83yg+mi8Rb0glXQjsxNdUKAI0plbtm",
  render_errors: [view: LycheeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Lychee.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "7HekGYwxATz33gM/rH9q2mV+uKJq5/Hu"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
