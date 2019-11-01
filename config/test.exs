use Mix.Config

# Configure your database
config :lychee, Lychee.Repo,
  username: "postgres",
  password: "postgres",
  database: "lychee_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lychee, LycheeWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
