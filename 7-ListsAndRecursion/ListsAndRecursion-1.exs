defmodule MyList do

    # Exercice 1
    def mapSum(list, func), do: mapSum(list, func, 0) 

    defp mapSum([], _func, value), do: value

    defp mapSum([head | tail], func, value) do
        headValue = func.(head)
        mapSum(tail, func, (value + headValue))
    end
end