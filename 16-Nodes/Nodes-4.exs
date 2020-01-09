# Exercice 4

defmodule Server do
  @name :server

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
        insert_client_in_loop(clients, client_pid)
        generator([client_pid | clients])
    end
  end

  defp insert_client_in_loop([], new_client) do
    send new_client, { :send_to, new_client }
    send new_client, { :tick } # Initilize timer
  end

  defp insert_client_in_loop([single_client], new_client) do
    send new_client, { :send_to, single_client }
    send single_client, { :send_to, new_client }
  end

  defp insert_client_in_loop(clients, new_client) do
    [ first_client | _ ] = clients
    [ last_client  | _ ] = clients |> Enum.reverse

    send new_client, { :send_to, first_client }
    send last_client, { :send_to, new_client }
  end
end

defmodule Client do
  @interval 2000 # 2 seconds

  def start(name) do
    pid = spawn(__MODULE__, :receiver, [name, self()])
    Server.register(pid)
  end

  def receiver(name, client) do
    receive do
      {:tick} ->
        IO.puts("Client #{inspect name}: tock")
        emiter(name, client)

      {:send_to, new_client} ->
        IO.puts("Client #{inspect name}: register new client as #{inspect client}")
        receiver(name, new_client)
    end
  end

  def emiter(name, client) do
    receive do
      {:send_to, new_client} ->
        IO.puts("Client #{inspect name}: register new client as #{inspect client}")
        emiter(name, new_client)

      after @interval ->
        IO.puts("Client #{inspect name}: send tick")
        send client, {:tick}
        receiver(name, client)
    end
  end
end
