defmodule MyStruct do
  defstruct alpha: 0, beta: 1
end

defimpl Inspect, for: MyStruct do
  def inspect(%MyStruct{ alpha: alpha_value, beta: beta_value }, _opts) do
    "%MyStruct{alpha:#{inspect alpha_value}, beta: #{inspect beta_value}}"
  end
end

IO.inspect %MyStruct{ alpha: 5 } # => %MyStruct{alpha: 5, beta: 1}

