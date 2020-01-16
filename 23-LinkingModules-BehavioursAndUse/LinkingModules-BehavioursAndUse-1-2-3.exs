defmodule Tracer do

  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  def run_function(definition={name, _, args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts IO.ANSI.format([
          "==> call: ",
          :yellow, "#{Tracer.dump_defn(unquote(name), unquote(args))}"
        ])

        result = unquote(content)
        IO.puts IO.ANSI.format([
          "<== result: ",
          :yellow, "#{result}"
        ])

        # Why does the first call to puts have to unquote the values in its interpolation but the second doesn't ?
        # Because, when calling unquote(content), we execute the body of the def function (the block after the do:)
        # result is the actual result of the expression, not a meta to interpret and process

        result
      end
    end
  end

  defmacro def({:when, _, [definition, _conditions]}, do: content) do
    run_function(definition, do: content)
  end

  defmacro def(definition, do: content) do
    run_function(definition, do: content)
  end

  defmacro __using__(_) do
   quote do
    import Kernel, except: [def: 2]
    import unquote(__MODULE__), only: [def: 2]
   end
  end
end


defmodule Test do
  use Tracer
  def square(a) when is_integer(a), do: a*a
  def puts_sum_three(a, b, c), do: IO.inspect(a + b + c)
  def add_list(list), do: Enum.sum(list)

end

Test.puts_sum_three(1, 2, 3)
Test.add_list([5, 6, 7, 8])
Test.square(5)
