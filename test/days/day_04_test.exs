defmodule Advent.Days.Day04Test do
  use ExUnit.Case, async: true

  alias Advent.Days.Day04

  @test_input """
              MMMSXXMASM
              MSAMXMSMSA
              AMXSXMAAMM
              MSAMASMSMX
              XMASAMXAMM
              XXAMMXXAMA
              SMSMSASXSS
              SAXAMASAAA
              MAMMMXMMMM
              MXMXAXMASX
              """
              |> String.trim()
              |> Day04.parse_input()

  test "counts xmas occurrences" do
    assert Day04.count_xmas(@test_input) == 18
  end

  test "counts x-mas occurrences" do
    assert Day04.count_x_mas(@test_input) == 9
  end
end
