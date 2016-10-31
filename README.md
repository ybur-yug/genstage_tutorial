# Genstage Example - Task Runner

## Stupid-Simple API
So, its not on hex or anything. But why not just `cp -r` it into an umbrella app and throw it in the deps with `in_umbrella: true` if youre really gonna use it?
This is just an example, not real software. There aren't even tests.

```elixir
# set the db username/pw to whatever yours is
# then `mix do deps.get, compile, ecto.create, ecto.migrate`

# We just want to pass a module, function, and args to `GenStage.enqueue/3`
# like so:
$ iex -S mix
iex> GenstageExample.enqueue(IO, :puts, ["farts"])
#=> A bunch of database background stuff happens etc
#=> Job is added to queue
#=> Job runs, yay!
#=> Try spinning it up with a ton, it has 12 workers per cpu core
```

## Yep, thats it.
