defmodule GenstageExample.Consumer do
  alias Experimental.GenStage
  use GenStage
  alias GenstageExample.{Producer, TaskSupervisor}

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [Producer]}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      %{id: id, payload: payload} = event
      {module, function, args} = payload |> deconstruct_payload
      task = start_task(module, function, args)
      yield_to_and_update_task(task, id)
    end
    {:noreply, [], state}
  end

  defp start_task(mod, func, args) do
    Task.Supervisor.async_nolink(TaskSupervisor, mod  , func, args)
  end

  defp yield_to_status({:ok, _}, _) do
    "success"
  end

  defp yield_to_status({:exit, _}, _) do
    "error"
  end

  defp yield_to_status(nil, task) do
    Task.shutdown(task)
    "timeout"
  end

  defp update(status, id) do
    GenstageExample.TaskDBInterface.update_task_status(id, status)
  end

  defp yield_to_and_update_task(task, id) do
    task
    |> Task.yield(1000)
    |> yield_to_status(task)
    |> update(id)
  end

  defp deconstruct_payload payload do
    payload |> :erlang.binary_to_term
  end
end
