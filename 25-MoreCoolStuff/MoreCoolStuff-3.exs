defmodule My.Sigil do
  def sigil_v(value, _) do
    case String.split(value, "\n") do
      [header|rows] ->
        headers = header |> parse_headers
        parse_rows(rows, headers)
      [] -> raise "string is empty"
    end
  end

  defp parse_headers(line_headers) do
    line_headers
    |> String.split(",")
    |> Enum.map(&String.to_atom/1)
  end

  defp parse_rows(rows, headers) do
    rows
    |> Enum.filter(fn row -> String.length(row) > 0 end)
    |> Enum.map(fn row -> row |> String.split(",") |> Enum.map(&try_parse_to_number/1) end)
    |> Enum.map(fn row -> Enum.zip(headers, row) end)
  end

  defp try_parse_to_number(s) do
    if String.contains?(s, ".") do
      case Float.parse(s) do
        { f, _rest } -> f
        :error -> s
      end
    else
      case Integer.parse(s) do
        { i, _rest } -> i
        :error -> s
      end
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
Item,Qty,Price
Teddy bear,4,34.95
Milk,1,2.99
Battery,6,8.00
"""
    # => [
    #  [Item: "Teddy bear", Qty: 4, Price: 34.96],
    #  [Item: "Milk", Qty: 1, Price: 2.99],
    #  [Item: "Battery", Qty: 6, Price: 8.00]
    # ]
  end
end

Tests.run_v_sigil()
