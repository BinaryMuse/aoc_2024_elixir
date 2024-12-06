defmodule Advent.Days.Day06Test do
  use ExUnit.Case, async: true

  alias Advent.Days.Day06

  @test_input """
              ....#.....
              .........#
              ..........
              ..#.......
              .......#..
              ..........
              .#..^.....
              ........#.
              #.........
              ......#...
              """
              |> String.trim()
  # |> Day06.parse_input()

  test "counts unique guard positions" do
    assert Day06.part1(@test_input) == 41
  end

  test "counts possible new obstruction locations" do
    assert Day06.part2(@test_input) == 6
  end
end
