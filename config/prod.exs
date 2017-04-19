use Mix.Config

# Configuration for production environment.
# It should read environment variables to follow 12 factor apps convention.

# Do not print debug messages in production
# and handle all other reports by Elixir Logger with JSON back-end
# SASL reports turned off because of their verbosity.
config :logger,
  backends: [LoggerJSON],
  level: :info,
  # handle_sasl_reports: true,
  handle_otp_reports: true

# Sometimes you might want to improve production performance by stripping logger debug calls during compilation
# config :logger,
#   compile_time_purge_level: :info


# Configure your database
config :postboy_api, Postboy.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: {:system, "DB_NAME"},
  username: {:system, "DB_USER"},
  password: {:system, "DB_PASSWORD"},
  hostname: {:system, "DB_HOST"},
  port: {:system, :integer, "DB_PORT"}

# For production, we often load configuration from external
# sources, such as your system environment. For this reason,
# you won't find the :http configuration below, but set inside
# Postboy.Web.Endpoint.load_from_system_env/1 dynamically.
# Any dynamic configuration should be moved to such function.
#
# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
#
# Finally, we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.
config :postboy_api, Postboy.Web.Endpoint,
  on_init: {Postboy.Web.Endpoint, :load_from_system_env, []},
  http: [port: {:system, "PORT", "80"}],
  url:  [
    host: {:system, "HOST", "localhost"},
    port: {:system, "PORT", "80"},
  ],
  secret_key_base: {:system, "SECRET_KEY"},
  debug_errors: false,
  code_reloader: false

# Do not log passwords, card data and tokens
config :phoenix, :filter_parameters, ["password", "secret", "token", "password_confirmation", "card", "pan", "cvv"]

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :sample2, Sample2.Web.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [:inet6,
#               port: 443,
#               keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#               certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables return an absolute path to
# the key and cert in disk or a relative path inside priv,
# for example "priv/ssl/server.key".
#
# We also recommend setting `force_ssl`, ensuring no data is
# ever sent via http, always redirecting to https:
#
#     config :sample2, Sample2.Web.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :sample2, Sample2.Web.Endpoint, server: true
#
config :phoenix, :serve_endpoints, true