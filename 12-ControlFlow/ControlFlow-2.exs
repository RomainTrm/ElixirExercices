defmodule ControlFlow do

  # Exercice 2
  # cond: Je n'aime pas trop, elle oblige de dupliquer les conditions
  # func: La solution claire et explicite, mais peut-être un peu lourde à maintenir si l'on doit changer la signature (type, nb. de paramètres...)
  # case: Pour moi le meilleurs compromis puisqu'il explicite uniquement les éléments significatifs à un cas, ex: %{ multipleOf3: true } pour Fizz, je suis sans doute biaisé par mon usage du match with de F#

  # FizzBuzz Functions
  def fizzBuzzFunc(n) when n > 0 do
    1..n |> Enum.map(&_fizzBuzzFunc&1)
  end

  defp _fizzBuzzFunc(number), do: _fizzBuzzFunc(rem(number, 3), rem(number, 5), number)
  defp _fizzBuzzFunc(0, 0, _number), do: "FizzBuzz"
  defp _fizzBuzzFunc(0, _multipleOfFive, _number), do: "Fizz"
  defp _fizzBuzzFunc(_multipleOfThree, 0, _number), do: "Buzz"
  defp _fizzBuzzFunc(_multipleOfThree, _multipleOfFive, number), do: number


  # FizzBuzz Cond
  def fizzBuzzCond(n) when n > 0 do
    1..n |> Enum.map(&_fizzBuzzCond&1)
  end

  defp _fizzBuzzCond(n) do
    cond do
      rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
      rem(n, 3) == 0 -> "Fizz"
      rem(n, 5) == 0 -> "Buzz"
      true -> n
    end
  end


  # FizzBuzz Case
  def fizzBuzzCase(n) when n > 0 do
    1..n |> Enum.map(&_fizzBuzzCase&1)
  end

  defp _fizzBuzzCase(n) do
    currentNumber = %{ multipleOf3: rem(n, 3) == 0, multipleOfFive: rem(n, 5) == 0 }
    case currentNumber do
      %{ multipleOf3: true, multipleOfFive: true } -> "FizzBuzz"
      %{ multipleOf3: true } -> "Fizz"
      %{ multipleOfFive: true } -> "Buzz"
      _ -> n
    end
  end

end
