# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pdv_backend,
  ecto_repos: [PdvBackend.Repo]

# Configures the endpoint
config :pdv_backend, PdvBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zZ8mZExsQATmTWyE8vFl8zZu1kUGUCIFxQtyFo6VGshHlcVwomqbSmQ1zvBeYjrm",
  render_errors: [view: PdvBackendWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PdvBackend.PubSub,
  live_view: [signing_salt: "WGsFu7+K"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
