defmodule Stack.Server do
  use GenServer

  def init(initial_stack) do
    { :ok, initial_stack }
  end

  def handle_call(:pop, _from, [head|tail]) do
    {:reply, head, tail}
  end

  def handle_call(:pop, _from, []) do
    {:stop, "Stack is empty", []}
  end

  def handle_cast({:push,element}, current_stack) do
    {:noreply, [element|current_stack]}
  end

  def terminate(reason, state) do
    IO.puts("Terminate server for reason: \"#{inspect reason}\"")
    IO.puts("Remaining stack: \"#{inspect state}\"")
  end
end
