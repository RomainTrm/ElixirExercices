defmodule My do
  defmacro macro(args) do
    IO.inspect args
  end
end

defmodule Tests do
  require My

  My.macro { 1, 2, 3 }
  # {:{}, [line: 3], [1, 2, 3]}

  My.macro 1+2
  # {:+, [line: 4], [1, 2]}

  quote do: { 1, 2, 3 }
  # {:{}, [], [1, 2, 3]}
end
