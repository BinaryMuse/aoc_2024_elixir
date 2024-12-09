defmodule Advent.Days.Day08Test do
  use ExUnit.Case, async: true

  alias Advent.Days.Day08

  @test_input """
              ............
              ........0...
              .....0......
              .......0....
              ....0.......
              ......A.....
              ............
              ............
              ........A...
              .........A..
              ............
              ............
              """
              |> String.trim()

  test "does stuff" do
    {_grid, data} = Day08.parse_input(@test_input)

    assert data == %{
             "0" => MapSet.new([{4, 4}, {5, 2}, {7, 3}, {8, 1}]),
             "A" => MapSet.new([{6, 5}, {8, 8}, {9, 9}])
           }
  end

  test "finds antinodes" do
    {grid, data} = Day08.parse_input(@test_input)
    assert Day08.get_antinodes(grid, data) |> Enum.count() == 14
  end

  test "finds more antinodes" do
    {grid, data} = Day08.parse_input(@test_input)
    assert Day08.get_more_antinodes(grid, data) |> Enum.count() == 34
  end
end
