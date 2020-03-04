defmodule GenstageExample.Task do
  def enqueue(list) when is_list(list) do
    GenstageExample.TaskDBInterface.insert_tasks(list)
  end

  def enqueue(payload) do
    GenstageExample.TaskDBInterface.insert_tasks([payload])
  end

  def take(limit) do
    GenstageExample.TaskDBInterface.take_tasks(limit)
  end
end
