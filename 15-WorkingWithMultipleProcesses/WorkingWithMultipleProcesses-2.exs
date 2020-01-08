defmodule Deterministic do

  def token_processor(sender) do
    receive do
      token = "betty" ->
        :timer.sleep(500)
        send(sender, "Response: #{token}")
      token ->
        send(sender, "Response: #{token}")
    end
  end

  def create_process(token) do
    process = spawn(Deterministic, :token_processor, [self()])
    IO.puts("Send token: #{token}")
    send(process, token)
  end

  def receiver() do
    receive do
      response ->
        IO.puts(response)
        receiver()
      after 1000 -> IO.puts("Stop listening")
    end
  end

  def run() do
    create_process("betty")
    create_process("fred")
    receiver()
  end

  # Is the order in which the replies are received deterministic in theory ? In practice ?
  # -> No, we can get the answer of the first spawned process after the second one (here using timer to slow down the process)

  # If either answer is no, how could you make it so ?
  # -> By waiting for first process to answer before spawning the second (place "receiver" code inside "create_process" function)
end
