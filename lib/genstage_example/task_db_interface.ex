defmodule GenstageExample.TaskDBInterface do
  import Ecto.Query
  alias GenstageExample.Repo

  def take_tasks(limit) do
    {:ok, {count, events}} =
      GenstageExample.Repo.transaction(fn ->
        ids = GenstageExample.Repo.all(waiting(limit))

        GenstageExample.Repo.update_all(by_ids(ids), set: [status: "running"])
      end)

    {count, events}
  end

  def insert_tasks(list) do
    Repo.insert_all(
      "tasks",
      Enum.map(list, fn payload = {_m, _f, _a} ->
        %{status: "waiting", payload: construct_payload(payload)}
      end)
    )
  end

  def update_task_status(id, status) do
    Repo.update_all(by_ids([id]), set: [status: status])
  end

  defp by_ids(ids) do
    from(t in "tasks",
      where: t.id in ^ids,
      select: %{
        id: t.id,
        payload: t.payload
      }
    )
  end

  defp waiting(limit) do
    from(t in "tasks",
      where: t.status == "waiting",
      limit: ^limit,
      select: t.id,
      lock: "FOR UPDATE SKIP LOCKED"
    )
  end

  defp construct_payload(mfa = {module, function, args}) do
    :erlang.term_to_binary(mfa)
  end
end
