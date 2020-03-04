defmodule GenstageExample do
  def start_later(list) do
    GenstageExample.Task.enqueue(list)
    GenstageExample.Producer.notify_producer()
  end

  def start_later(module, function, args) do
    GenstageExample.Task.enqueue({module, function, args})
    GenstageExample.Producer.notify_producer()
  end

  def auto_start_later do
    0..2000
    |> Enum.map(fn i ->
      {__MODULE__, :do_work, [i]}
    end)
    |> start_later()
  end

  def do_work(i) do
    IO.puts("Running :do_work(#{inspect(i)}) in PID #{inspect(self())}")
  end
end
