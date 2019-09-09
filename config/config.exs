# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :webkontist, WebKontistWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+mQrTx2ZM4grNvGoVRqseR1+EBmVHZBrQb+mCIaPZbtxLv2ne6ap1iHvwwD9G9xt",
  render_errors: [view: WebKontistWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WebKontist.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "NP2rjs0j"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# enable LiveView templates
config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
