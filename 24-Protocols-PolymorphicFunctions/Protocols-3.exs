defmodule MyEnum do
  def map(list, func) do
    list
    |> Enum.reduce([], fn elem, acc -> [func.(elem) | acc] end)
    |> Enum.reverse
  end

  def filter(list, func) do
    pass_filter = fn elem, acc ->
      if func.(elem) do
        [elem | acc]
      else
        acc
      end
    end

    list
    |> Enum.reduce([], pass_filter)
    |> Enum.reverse
  end

  def each(list, func) do
    list
    |> Enum.reduce(nil, fn elem, _ ->
      func.(elem)
      nil
    end)
  end
end


defmodule Tests do
  def run_map do
    list = [1, 2, 3, 4]
    func = fn x -> x + 5 end
    IO.inspect "Enum.map: #{inspect Enum.map(list, func)}"
    IO.inspect "MyEnum.map: #{inspect MyEnum.map(list, func)}"
  end

  def run_filter do
    list = [1, 2, 3, 4, 5, 6, 7]
    filter = fn x -> x > 3 end
    IO.inspect "Enum.filter: #{inspect Enum.filter(list, filter)}"
    IO.inspect "MyEnum.filter: #{inspect MyEnum.filter(list, filter)}"
  end

  def run_each do
    list = [1, 2, 3, 4]
    func = fn x -> IO.puts "Nb: #{x}" end
    IO.puts "Enum.each: "
    Enum.each(list, func)
    IO.puts "MyEnum.each: "
    MyEnum.each(list, func)
  end
end

Tests.run_map()
IO.puts("")
Tests.run_filter()
IO.puts("")
Tests.run_each()
