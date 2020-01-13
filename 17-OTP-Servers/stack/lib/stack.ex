defmodule Stack do
  @server Stack.Server

  def start_link(stack) do
    GenServer.start_link(@server, stack, name: @server)
  end

  def pop do
    GenServer.call(@server, :pop)
  end

  def push(element) do
    GenServer.cast(@server, {:push, element})
  end
end
