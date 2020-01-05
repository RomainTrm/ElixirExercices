defmodule ControlFlow do

  # Exercice 1
  def fizzBuzz(n) when n > 0 do
    1..n |> Enum.map(&_fizzBuzz&1)
  end

  defp _fizzBuzz(n) do
    currentNumber = %{ multipleOf3: rem(n, 3) == 0, multipleOfFive: rem(n, 5) == 0 }
    case currentNumber do
      %{ multipleOf3: true, multipleOfFive: true } -> "FizzBuzz"
      %{ multipleOf3: true, multipleOfFive: false } -> "Fizz"
      %{ multipleOf3: false, multipleOfFive: true } -> "Buzz"
      _ -> n
    end
  end

end
