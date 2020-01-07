defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1,
                             sort_into_descending_order: 1 ]

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

  test "Sort issues by descending dates" do
    result = ["c", "a", "b"] |> fake_created_at_list |> sort_into_descending_order
    assert Enum.map(result, &Map.get(&1, "created_at")) == ["c", "b", "a"]
  end

  defp fake_created_at_list(values) do
    for value <- values,
    do: %{ "created_at" => value, "other_data" => "xxx" }
  end
end
