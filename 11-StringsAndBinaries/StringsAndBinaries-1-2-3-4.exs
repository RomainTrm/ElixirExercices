defmodule MyStrings do
    
    # Exercice 1
    def is_printable?([]), do: true
    def is_printable?([head|tail]) when head in 32..126 do 
        is_printable?(tail)
    end
    def is_printable?(_str), do: false

    # Exercice 2
    def anagram?(word1, word2), do: sortLetters(word1) == sortLetters(word2)
    defp sortLetters(word), do: ~c"#{word}" |> Enum.sort

    # Exercice 3
    # ['cat' | 'dog'] affiche ['cat', 100, 111, 103] car 'cat' est considéré comme la head de la list (| operator)
    # ['cat', 'dog'] affiche bien ['cat', 'dog']

    # Exercice 4 string
    def calculateString(str) do
        [number1, number2] = Regex.split(~r{[+|-|*|/]}, str)
        [operator] = Regex.run(~r{[+|-|*|/]}, str)
        { parsedNumber1, _ } = number1 |> String.strip |> Integer.parse
        { parsedNumber2, _ } = number2 |> String.strip |> Integer.parse
        calculateString(parsedNumber1, operator, parsedNumber2)
    end
    defp calculateString(number1, "+", number2), do: number1 + number2
    defp calculateString(number1, "-", number2), do: number1 - number2
    defp calculateString(number1, "*", number2), do: number1 * number2
    defp calculateString(number1, "/", number2), do: div(number1, number2)

    # Exercice 4 single-quoted string
    def calculate(calculation) do
        calculate(calculation, 0, nil, 0)
    end

    defp calculate([], left, operation, right) do
        cond do
            operation == ?+ -> left + right
            operation == ?- -> left - right
            operation == ?* -> left * right
            operation == ?/ -> div(left, right)
        end
    end

    defp calculate([op|tail], left, _operator, right) when op == ?+ or op == ?- or op == ?* or op == ?/ do
        calculate(tail, left, op, right)
    end

    defp calculate([digit|tail], left, nil, _right) do
        newLeft = addDigit(left, digit)
        calculate(tail, newLeft, nil, 0)
    end

    defp calculate([digit|tail], left, op, right) do
        newRight = addDigit(right, digit)
        calculate(tail, left, op, newRight)
    end

    defp addDigit(value, 32), do: value #32 est le code pour l'espace
    defp addDigit(value, digit), do: value * 10 + (digit - ?0)
end