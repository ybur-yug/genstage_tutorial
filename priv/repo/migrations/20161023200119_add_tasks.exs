defmodule GenstageExample.Repo.Migrations.AddTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :payload, :binary, null: false
      add :status, :string, default: "waiting", null: false

      timestamps(updated_at: false, inserted_at: false)
    end
  end
end
