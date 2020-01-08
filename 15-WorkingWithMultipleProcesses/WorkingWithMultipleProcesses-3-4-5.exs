defmodule Links do

  def child_exit(sender) do
    receive do
      message ->
        send(sender, "Response: #{message}")
        # raise :boom
        exit(:boom)
    end
  end

  def child_raise(sender) do
    receive do
      message ->
        send(sender, "Response: #{message}")
        raise :boom
    end
  end

  # Display only exit for given PID
  def run_link_exit() do
    spawn_link(Links, :child_exit, [self()]) |> run
  end

  # Display exit for given PID and specify raised exception
  def run_link_raise() do
    spawn_link(Links, :child_raise, [self()]) |> run
  end

  # Display an ArgumentError for given PID
  def run_monitor_exit() do
    spawn_monitor(Links, :child_exit, [self()]) |> run
  end

  # Display an ArgumentError for given PID (same as run_monitor_exit)
  def run_monitor_raise() do
    spawn_monitor(Links, :child_raise, [self()]) |> run
  end

  def run(process) do
    send(process, "Hello")

    :timer.sleep(500)
    receive do
      response ->
        IO.puts(response)
    end

  end
end
