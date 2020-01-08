defmodule Fibonacci do
  def fib(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :fib, n, client} ->
        send client, { :answer, n, fib_calc(n), self() }
        fib(scheduler)
      { :shutdown } -> exit(:normal)
    end
  end

  # Compute in a very inefficient way to load CPU
  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n-2)
end

defmodule Scheduler do
  def run(nb_processes, module, func, to_calculate) do
    (1..nb_processes)
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, { :fib, next, self() }
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, :shutdown
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, n, result, _pid} ->
        schedule_processes(processes, queue, [ { n, result } | results ])
    end
  end
end

defmodule RunProcesses do

  def run() do
    to_process = List.duplicate(37, 20)

    Enum.each(1..10, fn nb_processes ->
      { time, result } = :timer.tc(Scheduler, :run, [nb_processes, Fibonacci, :fib, to_process])

      if nb_processes == 1 do
        IO.inspect(result)
        IO.puts("\n #  Time (s)")
      end
      :io.format("~2B  ~.2f~n", [nb_processes, time/1000000.0])
    end)
  end
end
