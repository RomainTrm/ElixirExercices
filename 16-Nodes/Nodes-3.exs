# Exercice 3

defmodule Timer do
  @interval 2000 # 2 seconds
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients) do
    receive do
      {:register, client_pid} ->
        IO.puts("registering #{inspect client_pid}")
        generator([client_pid | clients])
      after @interval ->
        tick(clients)
    end
  end

  defp tick([]) do
    IO.puts("tick")
    generator([])
  end

  defp tick([client | clients]) do
    IO.puts("tick")
    send client, { :tick }
    generator(clients ++ [client])
  end
end

defmodule Client do
  def start(name) do
    pid = spawn(__MODULE__, :receiver, [name])
    Timer.register(pid)
  end

  def receiver(name) do
    receive do
      {:tick} ->
        IO.puts("tock on #{inspect name}")
        receiver(name)
    end
  end
end
