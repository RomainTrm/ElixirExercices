defmodule MyStrings do

    # Exercice 6
    @delimiter ". "
    def capitalize_sentences(sentences) do
        sentences
        |> String.split(@delimiter)
        |> Enum.map(&String.capitalize&1)
        |> Enum.join(@delimiter)
    end

    # Exercice 7
    def runApplyTaxes do
        {:ok, file} = File.open("taxes-input.csv")
        _header = IO.read(file, :line)

        file
        |> IO.stream(:line)
        |> Stream.map(&String.trim&1)
        |> Stream.map(&String.split(&1, ","))
        |> Enum.map(fn [id, ship_to, net_amount] ->
            [
                id: String.to_integer(id),
                ship_to: ship_to |> String.replace(":", "") |> String.to_atom,
                net_amount: String.to_float(net_amount)
            ]
        end)
        |> _applyTaxes
    end

    defp _applyTaxes(orders) do
        orders
        |> Enum.map(fn order ->
            total_amount = _applyTaxe(order[:ship_to], order[:net_amount])
            order++[total_amount: total_amount]
            end)
    end

    defp _applyTaxe(ship_to, net_amount) do
        tax_rates = [ NC: 0.075, TX: 0.08 ]
        if tax_rates[ship_to] == nil do
            net_amount
        else
            net_amount * (1.0 + tax_rates[ship_to])
        end
    end

end
