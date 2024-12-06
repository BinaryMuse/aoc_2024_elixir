defmodule Helpers.GridTest do
  use ExUnit.Case, async: true

  alias Advent.Helpers.Grid
  alias Advent.Helpers.Grid.Cell

  @rows [
    [".", ".", "O", ".", "."],
    [".", "X", ".", ".", "."],
    [".", ".", ".", "X", "X"],
    [".", ".", ".", ".", "."],
    ["X", ".", ".", ".", "."]
  ]

  test "cell moves in correct directions" do
    cell = {4, 3}

    assert {4, 2} == Cell.north(cell)
    assert {4, 4} == Cell.south(cell)
    assert {3, 3} == Cell.west(cell)
    assert {5, 3} == Cell.east(cell)
  end

  test "populates a grid" do
    grid = Grid.new(@rows)

    assert Grid.at(grid, {0, 4}) == "X"
    assert Grid.at(grid, {2, 0}) == "O"
    assert Grid.at(grid, {4, 4}) == "."
  end

  test "puts stuff in the grid" do
    grid = Grid.new(@rows)

    assert Grid.at(grid, {0, 4}) == "X"
    grid = Grid.put(grid, {0, 4}, "!")
    assert Grid.at(grid, {0, 4}) == "!"
  end

  test "with_cell iterates over the grid" do
    grid = Grid.new(@rows)

    assert Grid.with_cell(grid)
           |> Enum.drop(2)
           |> List.first() == {"O", {2, 0}}
  end
end
