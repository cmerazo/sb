# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sb,
  ecto_repos: [Sb.Repo]

# Configures the endpoint
config :sb, SbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ksTc4Ln0v/vNdkhKvE6v1KGKAutNI2JHo55RrvrBdqor7w8GiY9hGW0Y7X0j9qkc",
  render_errors: [view: SbWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config Google Maps
config :google_maps,
  api_key: "AIzaSyAGi2DzC-UBYivHrYwejfe0CNCJOmhukxM"

# Config money formatter
config :currency_formatter, :whitelist, ["EUR", "USD"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
