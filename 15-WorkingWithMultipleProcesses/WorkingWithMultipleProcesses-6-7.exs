defmodule Parallel do
  def pmap(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn elem ->
      spawn_link(fn -> send me, { self(), fun.(elem) } end)
    end)
    |> Enum.map(fn pid ->
      receive do { ^pid, result} -> result end
    end)
  end

  # Why use a separate variable me ?
  # -> me represent the pid of the function pmap, when we do self() on the first Enum.map, we are on the context of an anonimous fonction
  # -> So the self() != me, if we don't do this, we won't get back any result because we don't send them to pmap function

  # On the receive, if we tipes _pid of ^pid, we can't guarantee the result to be in the correct order
end
