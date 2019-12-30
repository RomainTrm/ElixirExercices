defmodule MyList do

    # Exercice 2
    def max(list), do: myMax(list, 0)

    defp myMax([], maximum), do: maximum

    defp myMax([head|tail], maximum) when head > maximum do 
        myMax(tail, head)
    end

    defp myMax([_head|tail], maximum) do
        myMax(tail, maximum)
    end
end