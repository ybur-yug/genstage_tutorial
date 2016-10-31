defmodule GenstageExample.TaskDBInterface do
  import Ecto.Query

  def take_tasks(limit) do
    {:ok, {count, events}} =
      GenstageExample.Repo.transaction fn ->
        ids = GenstageExample.Repo.all waiting(limit)
        GenstageExample.Repo.update_all by_ids(ids), [set: [status: "running"]], [returning: [:id, :payload]]
      end
    {count, events}
  end

  def insert_tasks(status, payload) do
    GenstageExample.Repo.insert_all "tasks", [
      %{status: status, payload: payload}
    ]
  end

  def update_task_status(id, status) do
    GenstageExample.Repo.update_all by_ids([id]), set: [status: status]
  end

  defp by_ids(ids) do
    from t in "tasks", where: t.id in ^ids
  end

  defp waiting(limit) do
    from t in "tasks",
      where: t.status == "waiting",
      limit: ^limit,
      select: t.id,
      lock: "FOR UPDATE SKIP LOCKED"
  end
end
