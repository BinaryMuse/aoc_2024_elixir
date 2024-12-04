defmodule Helpers.GridTest do
  use ExUnit.Case, async: true

  alias Advent.Helpers.Grid
  alias Advent.Helpers.Grid.Cell

  test "cell moves in correct directions" do
    cell = {4, 3}

    assert {4, 2} == Cell.north(cell)
    assert {4, 4} == Cell.south(cell)
    assert {3, 3} == Cell.west(cell)
    assert {5, 3} == Cell.east(cell)
  end

  test "populates a grid" do
    rows = [
      [".", ".", "O", ".", "."],
      [".", "X", ".", ".", "."],
      [".", ".", ".", "X", "X"],
      [".", ".", ".", ".", "."],
      ["X", ".", ".", ".", "."]
    ]

    grid = Grid.new(rows)

    assert Grid.at(grid, {0, 4}) == "X"
    assert Grid.at(grid, {2, 0}) == "O"
    assert Grid.at(grid, {4, 4}) == "."
  end
end
