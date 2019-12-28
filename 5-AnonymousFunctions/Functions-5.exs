map_before = Enum.map [1,2,3,4], fn x -> x + 2 end

map_after = Enum.map [1,2,3,4], &(&1+2)

IO.puts "Map before equal map after: \"#{map_before === map_after}\""
IO.puts ""

IO.puts "Each before:"
each_before = Enum.each [1,2,3,4], fn x -> IO.inspect x end
IO.puts ""
IO.puts "Each after:"
each_after = Enum.each [1,2,3,4], &IO.inspect/1