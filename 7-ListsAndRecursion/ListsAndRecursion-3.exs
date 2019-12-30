defmodule MyList do

    # Exercice 3
    def caesar(list, n) do
        list |> Enum.map (&cypher(&1, n))
    end

    defp cypher(letter, 0), do: letter
    
    defp cypher(?z, n) do
        cypher(?a, n - 1)
    end

    defp cypher(letter, n) do
        cypher(letter + 1, n - 1)
    end
end