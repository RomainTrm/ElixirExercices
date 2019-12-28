fizzBuzzInternal = fn
    0, 0, _ -> "FizzBuzz"
    0, _, _ -> "Fizz"
    _, 0, _ -> "Buzz"
    _, _, a -> a
end

fizzBuzz = fn x -> 
    with fizz = rem(x, 3),
         buzz = rem(x, 5)
    do
        fizzBuzzInternal.(fizz, buzz, x)
    end
end

IO.puts "Expected: \"FizzBuzz\" for 15"
IO.puts "Result: \"#{fizzBuzz.(15)}\""

IO.puts "Expected: \"Fizz\" for 12"
IO.puts "Result: \"#{fizzBuzz.(12)}\""

IO.puts "Expected: \"Buzz\" for 10"
IO.puts "Result: \"#{fizzBuzz.(10)}\""

IO.puts "Expected: \"11\" for 11"
IO.puts "Result: \"#{fizzBuzz.(11)}\""