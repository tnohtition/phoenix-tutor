# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :url_char_counting, UrlCharCountingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IvM/qyANNvj6dswRc+GLCxC0N3okn7B/MVkjiefsA8T/E7QxML4hCQ4iQlfHIx8e",
  render_errors: [view: UrlCharCountingWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: UrlCharCounting.PubSub,
  live_view: [signing_salt: "tciXlxKA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
