import Config

config :genstage_example, ecto_repos: [GenstageExample.Repo]

config :genstage_example, GenstageExample.Repo,
  database: "genstage_example_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
