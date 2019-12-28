fizzBuzz = fn
    0, 0, _ -> "FizzBuzz"
    0, _, _ -> "Fizz"
    _, 0, _ -> "Buzz"
    _, _, a -> a
end

IO.puts "Expected: \"FizzBuzz\""
IO.puts "Result: \"#{fizzBuzz.(0,0,4)}\""

IO.puts "Expected: \"Fizz\""
IO.puts "Result: \"#{fizzBuzz.(0,3,4)}\""

IO.puts "Expected: \"Buzz\""
IO.puts "Result: \"#{fizzBuzz.(1,0,4)}\""

IO.puts "Expected: \"4\""
IO.puts "Result: \"#{fizzBuzz.(1,2,4)}\""