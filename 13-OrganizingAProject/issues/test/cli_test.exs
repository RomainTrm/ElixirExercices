defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1 ]

  test ":help returned by passing -h or --help" do
    assert parse_args(["-h",     "Whatever"]) == :help
    assert parse_args(["--help", "Whatever"]) == :help
  end

  test "Three values return if three given" do
    assert parse_args(["user", "project", "9"]) == { "user", "project", 9 }
  end

  test "Count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end
end
