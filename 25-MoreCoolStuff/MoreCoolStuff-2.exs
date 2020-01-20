defmodule My.Sigil do
  def sigil_v(value, _) do
    String.split(value, "\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(fn s -> s |> String.split(",") |> Enum.map(&try_parse_to_float/1) end)
  end

  defp try_parse_to_float(s) do
    case Float.parse(s) do
      { f, _rest } -> f
      :error -> s
    end
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
1,2,3.14
cat,dog
"""
    # => [[1.0,2.0,3.14],["cat","dog"]]
  end
end

Tests.run_v_sigil()
