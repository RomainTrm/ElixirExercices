defmodule My.Sigil do
  def sigil_v(value, _) do
    String.split(value, "\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(fn s -> String.split(s, ",") end)
  end

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
    end
  end
end

defmodule Tests do
  import My.Sigil

  def run_v_sigil do
    IO.inspect ~v"""
1,2,3
cat,dog
"""
    # => [["1","2","3"],["cat","dog"]]
  end
end

Tests.run_v_sigil()
