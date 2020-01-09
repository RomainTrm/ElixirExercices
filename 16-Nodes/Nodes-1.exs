# Exercice 1
# Window 1
# ..\directory 1> iex --sname Node1

# Window 2
# ..\directory 2>iex --sname Node2
# iex(Node2@machine_name)> Node.connect(:Node1@machine_name)

# Window 1
# iex(Node1@machine_name)> fun fn -> IO.puts("Print me: #{inspect(self())}) end
# iex(Node1@machine_name)> Node.spawn(:Node1@machine_name, fun)
# iex(Node1@machine_name)> Node.spawn(:Node2@machine_name, fun)
