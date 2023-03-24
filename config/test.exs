import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :quick_note, QuickNote.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "quick_note_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  port: 1234

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :quick_note, QuickNoteWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "lDU7HSxM2puRsDjswh3RuWu0E3djKgyJfGhIcMEufDejmCP7MPUIe9pMVmJWWGGa",
  server: false

# In test we don't send emails.
config :quick_note, QuickNote.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
