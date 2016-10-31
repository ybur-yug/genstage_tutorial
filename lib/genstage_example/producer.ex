defmodule GenstageExample.Producer do
  alias Experimental.GenStage
  use GenStage

  @name __MODULE__

  def start_link do
    GenStage.start_link(__MODULE__, 0, name: @name)
  end

  def init(counter) do
    {:producer, counter}
  end

  def enqueue(module, function, args) do
    payload = {module, function, args} |> construct_payload
    GenstageExample.Task.enqueue("waiting", payload)
    Process.send(@name, :enqueued, [])
    :ok
  end

  def handle_cast(:enqueued, state) do
    serve_jobs(state)
  end

  def handle_demand(demand, state) do
    serve_jobs(demand + state)
  end

  def handle_info(:enqueued, state) do
    {count, events} = GenstageExample.Task.take(state)
    {:noreply, events, state - count}
  end

  def serve_jobs limit do
    {count, events} = GenstageExample.Task.take(limit)
    Process.send_after(@name, :enqueued, 60_000)
    {:noreply, events, limit - count}
  end

  defp construct_payload({module, function, args}) do
    {module, function, args} |> :erlang.term_to_binary
  end
end
