defmodule GenstageExample.Repo do
  use Ecto.Repo,
    otp_app: :genstage_example,
    adapter: Ecto.Adapters.Postgres
end
