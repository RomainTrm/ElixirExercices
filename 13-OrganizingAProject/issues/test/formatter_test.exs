defmodule FormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest Issues

  alias Issues.TableFormatter, as: TF

  @simple_test_data [
    [ c1: "r1 c1", c2: "r1 c2", c3: "r1 c3", c4: "r1+++c4" ],
    [ c1: "r2 c1", c2: "r2 c2", c3: "r2 c3", c4: "r2 c4" ],
    [ c1: "r3 c1", c2: "r3 c2", c3: "r3 c3", c4: "r3 c4" ],
    [ c1: "r4 c1", c2: "r4++c2", c3: "r4 c3", c4: "r4 c4" ],
  ]

  @header [ :c1, :c2, :c4 ]

  defp split_columns(), do: TF.split_into_columns(@simple_test_data, @header)

  test "Split into columns" do
    columns = split_columns()
    assert length(columns) == length(@header)
    assert columns == [
      [ "r1 c1", "r2 c1", "r3 c1", "r4 c1" ],
      [ "r1 c2", "r2 c2", "r3 c2", "r4++c2" ],
      [ "r1+++c4", "r2 c4", "r3 c4", "r4 c4" ]
    ]
  end

  test "Correct width for each column" do
    widths = split_columns() |> TF.width_of
    assert widths == [ 5, 6, 7 ]
  end

  test "Correct format for each column" do
    formats = TF.format_for([ 9, 10, 11 ])
    assert  formats == "~-9s | ~-10s | ~-11s~n"
  end

  test "Output is correct" do
    output = capture_io fn -> TF.print_table(@simple_test_data, @header) end
    assert output == """
    c1    | c2     | c4     
    ------+--------+--------
    r1 c1 | r1 c2  | r1+++c4
    r2 c1 | r2 c2  | r2 c4  
    r3 c1 | r3 c2  | r3 c4  
    r4 c1 | r4++c2 | r4 c4  
    """
  end
end
