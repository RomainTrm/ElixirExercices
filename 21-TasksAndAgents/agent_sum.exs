
{ :ok, agent } = Agent.start(fn -> 0 end, name: Sum)
IO.puts Agent.get(agent, &(&1))

IO.puts "Add 1"
Agent.update(agent, &(&1 + 1))
IO.puts Agent.get(Sum, &(&1))

IO.puts "Add 1"
Agent.update(Sum, &(&1 + 1))
IO.puts Agent.get(Sum, &(&1))
