use Mix.Config

config :genstage_example, ecto_repos: [GenstageExample.Repo]

config :genstage_example, GenstageExample.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "genstage_example",
  username: "bobdawg",
  password: "",
  hostname: "localhost",
  port: "5432"

