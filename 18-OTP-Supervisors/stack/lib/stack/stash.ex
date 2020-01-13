defmodule Stack.Stash do
  use GenServer

  # Stash
  def init(initial_stack) do
    { :ok, initial_stack }
  end

  def handle_call(:get, _from, stack) do
    {:reply, stack, stack}
  end

  def handle_cast({:save,stack}, _) do
    {:noreply, stack}
  end

  # Public APIs
  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def save(stack) do
    GenServer.cast(__MODULE__, {:save, stack})
  end
end
