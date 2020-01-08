defmodule Crawler do
  def crawl(scheduler, search) do
    send scheduler, {:ready, self()}
    receive do
      { :run, file, client } ->
        send client, { :answer, file, count_in_file(file, search), self() }
        crawl(scheduler, search)
      { :shutdown } -> exit(:normal)
    end
  end

  defp count_in_file(file, search) do
    (File.read!(file)
    |> String.split(search)
    |> length) - 1
  end
end

defmodule Scheduler do
  def run(module, func, func_args, queue, max_nb_processes \\ 5) do
    nb_processes = min(max_nb_processes, length(queue))
    IO.puts("Queue size: #{length(queue)}")
    IO.puts("Nb of spawned processes: #{nb_processes}")

    1..nb_processes
    |> Enum.map(fn _ -> spawn(module, func, [self() | func_args]) end)
    |> schedule_processes(queue, 0)
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when queue != [] ->
        [ next | tail ] = queue
        send pid, { :run, next, self() }
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, :shutdown
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          results
        end

      {:answer, _file, count, _pid} ->
        schedule_processes(processes, queue, results + count)
    end
  end
end

defmodule RunProcesses do
  def run() do
    search = "cat"
    IO.puts("Searching \"#{search}\" on current directory.")
    result = Scheduler.run(Crawler, :crawl, [search], File.ls!("."))
    IO.puts("Number of \"#{search}\": #{result}")
  end
end
