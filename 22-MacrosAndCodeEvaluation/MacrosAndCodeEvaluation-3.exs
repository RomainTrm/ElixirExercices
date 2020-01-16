defmodule Explain do

  # Solution found here : https://github.com/carlos4ndre/elixir-exercises/blob/master/chapter-20/macros-and-code-evaluation-3/my_math.ex

  defmacro explain(clauses) do
    IO.inspect(clauses)
    expression = Keyword.get(clauses, :do, nil)

    { _, translated_expression } = Macro.postwalk(expression, [], fn
      {operation, _, [left, right]}, acc when is_number(left) and is_number(right) ->
        translation = "#{translate_operation(operation)} #{left} and #{right}"
        {"", acc ++ [translation]}
      {operation, _, ["", right]}, acc when is_number(right) ->
        translation = "then #{translate_operation(operation)} #{right}"
        {"", acc ++ [translation]}
      {operation, _, [left, _right]}, acc when is_number(left) ->
        translation = "then #{translate_operation(operation)} #{left}"
        {"", acc ++ [translation]}
      other, acc ->
        {other, acc}
    end)

    translated_expression
    |> Enum.join(", ")
    |> IO.inspect
  end

  def translate_operation(operation) do
    case operation do
      :+ -> "add"
      :- -> "subtract"
      :* -> "multiply"
      :/ -> "divide"
      _  -> raise "Invalid operator"
    end
  end
end

defmodule Test do
  require Explain
  Explain.explain do: 4 + 5 * 2
end
