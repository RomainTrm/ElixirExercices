defmodule Chop do
    def guess(toGuess, range, myGuess \\ -1)

    def guess(toGuess, range, -1) do
        newGuess = makeGuess(range)
        guess(toGuess, range, newGuess)        
    end

    def guess(toGuess, _, myGuess) when toGuess == myGuess do
        IO.puts "Yes, it is #{toGuess}!"
    end

    def guess(toGuess, min.._, myGuess) when myGuess > toGuess do
        IO.puts "Too high"
        newRange = min..myGuess
        newGuess = makeGuess(newRange)
        guess(toGuess, newRange, newGuess)        
    end

    def guess(toGuess, _..max, myGuess) when myGuess < toGuess do
        IO.puts "Too low"
        newRange = myGuess..max
        newGuess = makeGuess(newRange)
        guess(toGuess, newRange, newGuess)        
    end

    defp makeGuess(min..max) do
        currentGuess = div(max - min, 2) + min
        IO.puts "Is it #{currentGuess}?"
        currentGuess
    end
end