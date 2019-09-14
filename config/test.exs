use Mix.Config

# Configure your database
config :has_many_live_view, HasManyLiveView.Repo,
  username: "postgres",
  password: "postgres",
  database: "has_many_live_view_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :has_many_live_view, HasManyLiveViewWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
