defmodule Issues.TableFormatter do

  def print_table(rows, headers) do
    with columns = split_into_columns(rows, headers),
         column_widths = width_of(columns),
         format = format_for(column_widths)
    do
      puts_one_line_in_columns(headers, format)
      IO.puts(separator(column_widths))
      puts_in_columns(columns, format)
    end
  end

  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: printable(row[header])
    end
  end

  defp printable(str) when is_binary(str), do: str
  defp printable(str), do: to_string(str)

  def width_of(columns) do
    for col <- columns,
    do: col |> Enum.map(&String.length/1) |> Enum.max
  end

  def format_for(column_widths) do
    Enum.map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  defp separator(column_widths) do
    Enum.map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  defp puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.each(&puts_one_line_in_columns(&1, format))
  end

  defp puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end

end
