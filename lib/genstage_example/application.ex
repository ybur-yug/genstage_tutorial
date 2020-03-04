defmodule GenstageExample do
  use Application

  alias GenstageExample.{Producer, Consumer, Repo}

  def start(_type, _args) do
    # 12 workers / system core
    consumers =
      for id <- 0..(System.schedulers_online() * 12) do
        Supervisor.child_spec({Consumer, []}, id: id)
      end

    producers = [
      {Producer, []}
    ]

    supervisors = [
      {Repo, []},
      {Task.Supervisor, name: GenstageExample.TaskSupervisor}
    ]

    children = supervisors ++ producers ++ consumers

    opts = [strategy: :one_for_one, name: GenstageExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_later(list) do
    GenstageExample.Task.enqueue(list)
    notify_producer()
  end

  def start_later(module, function, args) do
    GenstageExample.Task.enqueue({module, function, args})
    notify_producer()
  end

  defdelegate notify_producer(), to: Producer
end
