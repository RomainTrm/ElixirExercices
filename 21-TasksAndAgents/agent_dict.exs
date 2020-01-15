defmodule Frequency do
  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def add_word(word) do
    Agent.update(
      __MODULE__,
      fn dic ->
        Map.update(dic, word, 1, &(&1+1))
      end)
  end

  def count_for(word) do
    Agent.get(__MODULE__, fn dic -> Map.get(dic, word) end)
  end

  def words do
    Agent.get(__MODULE__, &Map.keys/1)
  end
end
