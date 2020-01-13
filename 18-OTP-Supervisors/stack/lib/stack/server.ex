defmodule Stack.Server do
  use GenServer

  # Server
  def init(_) do
    { :ok, Stack.Stash.get() }
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
    Stack.Stash.save(state)
    IO.puts("Terminate server for reason: \"#{inspect reason}\"")
    IO.puts("Remaining stack: \"#{inspect state}\"")
  end

  # Public APIs
  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(element) do
    GenServer.cast(__MODULE__, {:push, element})
  end
end
