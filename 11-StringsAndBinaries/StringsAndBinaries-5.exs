defmodule MyStrings do
    
    # Exercice 5
    def center(words) do
        maxLength = _maxLength(words)
        words
        |> Enum.map(&_padWord(&1, maxLength))
        |> Enum.each(&IO.puts&1)
    end

    defp _padWord(word, maxLength) do 
        wordLength = String.length(word)
        nbToSlice = div((maxLength - wordLength), 2)
        String.pad_leading(word, nbToSlice + wordLength)
    end

    defp _maxLength(words), do: words |> Enum.map(&String.length&1) |> Enum.max
end