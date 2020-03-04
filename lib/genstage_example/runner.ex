defmodule GenstageExample.Runner do
  alias GenstageExample, as: App

  def run do
    0..2000
    |> Enum.map(fn i ->
      {__MODULE__, :do_work, [i]}
    end)
    |> App.start_later()
  end

  def do_work(i) do
    IO.puts("Running :do_work(#{inspect(i)}) in PID #{inspect(self())}")
  end
end
