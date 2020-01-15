defmodule StackTest do
  use ExUnit.Case
  alias Stack.Server

  test "pop from initial stack" do
    assert Server.pop == 1
  end

  test "pop last pushed element" do
    Server.push(5)
    assert Server.pop == 5
  end
end
