defmodule My do
  defmacro if(condition, clauses) do
    if_clause = Keyword.get(clauses, :do)
    else_clause = Keyword.get(clauses, :else)
    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(else_clause)
        _ -> unquote(if_clause)
      end
    end
  end

  defmacro unless(condition, clauses) do
    unless_clause = Keyword.get(clauses, :do)
    else_clause = Keyword.get(clauses, :else)
    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(unless_clause)
        _ -> unquote(else_clause)
      end
    end
  end
end
