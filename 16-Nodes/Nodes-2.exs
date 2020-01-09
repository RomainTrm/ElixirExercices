# Exercice 2

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
        IO.puts("tick")
        Enum.each clients, fn client -> send client, { :tick } end
        generator(clients)
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Timer.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts("tock")
        receiver()
    end
  end
end


# Why did I say "about" 2 when it looks as the time should be pretty accurate ?
# Because we send a :tick after 2 seconds without a new :register message
# If we receive a :register, we process it and then wait for 2 seconds before sending a :tick
# We could register a new client every 1.5 seconds and never send any :tick
