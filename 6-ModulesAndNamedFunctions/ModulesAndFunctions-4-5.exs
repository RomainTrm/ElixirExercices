defmodule Math do
    # Exercice 4
    def sum(1), do: 1
    def sum(n), do: n + sum(n-1) 

    # Exercice 5
    def gdc(x, 0), do: x
    def gdc(x, y), do: gdc(y, rem(x, y))
end