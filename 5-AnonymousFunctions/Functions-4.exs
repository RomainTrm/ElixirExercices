prefix = fn p -> 
    fn name ->
        "#{p} #{name}"
    end
end

mr = prefix.("Mr")
bond = mr.("Bond")

IO.puts bond

IO.puts prefix.("Stan").("Smith")