# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :has_many_live_view,
  ecto_repos: [HasManyLiveView.Repo]

# Configures the endpoint
config :has_many_live_view, HasManyLiveViewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wL/N09G8jZ8AVhetdsN501lUbuZcfPYg2XrOpcUmU5OztatrSt9bMvLJODm2TlSj",
  render_errors: [view: HasManyLiveViewWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HasManyLiveView.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "z8lyn52HKxabrLRisv2CkRPc72ZwLQop"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
