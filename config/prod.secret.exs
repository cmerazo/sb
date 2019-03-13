use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :sb, SbWeb.Endpoint,
  secret_key_base: "bp3O2f49DI6S0TqzPPMyvWgg9BpdF/rpQO9jqwImxJIKZB/eK9oU/iUpaXe+/UMQ"

# Configure your database
config :sb, Sb.Repo,
  username: "postgres",
  password: "postgres",
  database: "sb_prod",
  pool_size: 15
