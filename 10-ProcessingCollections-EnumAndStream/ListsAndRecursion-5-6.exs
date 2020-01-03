defmodule MyList do

    # Exercice 5
    def all?([], _condition), do: true
    def all?([head|tail], condition) do
        condition.(head) && all?(tail, condition)
    end

    def each([], _action), do: :ok
    def each([head|tail], action) do
        action.(head)
        each(tail, action)
    end

    def filter([], _condition), do: []
    def filter([head|tail], condition) do
        if condition.(head) do
            [head|filter(tail, condition)]
        else
            filter(tail, condition)
        end
    end

    def split([], _indexToSplit), do: {[], []}
    def split(list, indexToSplit) when indexToSplit <= 0, do: {[], list}
    def split([head|tail], indexToSplit) do
        {begin, rest} = split(tail, indexToSplit - 1)
        {[head|begin], rest}
    end

    def take([], _nbToTake), do: []
    def take(_list, nbToTake) when nbToTake <= 0, do: []
    def take([head|tail], nbToTake) do 
        [head|take(tail, nbToTake - 1)]
    end

    # Exercice 6
    def flatten([]), do: []
    def flatten([head|tail]) when is_list(head) do
        flatten(head) ++ flatten(tail)
    end
    def flatten([head|tail]) do
        [head|flatten(tail)]
    end
end