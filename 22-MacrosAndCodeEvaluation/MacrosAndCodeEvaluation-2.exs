defmodule Times do
  defmacro times_n(n) do
    quote do
      def unquote(:"times_#{n}")(val) do
        unquote(n) * val
      end
    end
  end
end

defmodule Tests do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end

IO.puts Tests.times_3(4) # => 12
IO.puts Tests.times_4(5) # => 20
