defmodule GenstageExample.Producer do
  use GenStage

  @name __MODULE__

  def start_link(_) do
    GenStage.start_link(@name, 0, name: @name)
  end

  def init(counter) do
    {:producer, counter}
  end

  def notify_producer do
    GenStage.cast(@name, :data_inserted)
  end

  def handle_cast(:data_inserted, state) do
    serve_jobs(state)
  end

  def handle_demand(demand, state) do
    serve_jobs(demand + state)
  end

  def serve_jobs(limit) do
    {count, events} = GenstageExample.Task.take(limit)
    {:noreply, events, limit - count}
  end
end
