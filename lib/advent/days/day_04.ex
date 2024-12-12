defmodule Advent.Days.Day04 do
  use Advent.Day

  alias Advent.Helpers.Grid

  def run(input) do
    grid = parse_input(input)

    count = count_xmas(grid)
    IO.puts("Part 1: #{count}")

    count = count_x_mas(grid)
    IO.puts("Part 2: #{count}")
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Grid.new()
  end

  # XMAS SEARCH

  def count_xmas(grid) do
    for x <- 1..grid.width, y <- 1..grid.height do
      coord = {x - 1, y - 1}

      case Grid.fetch(grid, coord) do
        {:ok, "X"} -> count_xmas_from_cell(grid, coord)
        _ -> 0
      end
    end
    |> Enum.sum()
  end

  defp count_xmas_from_cell(grid, origin) do
    for dir <- [:north, :south, :east, :west, :ne, :nw, :se, :sw] do
      count_xmas_in_dir(grid, origin, dir)
    end
    |> Enum.sum()
  end

  defp count_xmas_in_dir(grid, origin, dir) do
    results =
      0..3
      |> Enum.map(&apply(Grid.Cell, dir, [origin, &1]))
      |> Enum.map(&Grid.at(grid, &1, "_"))
      |> Enum.join("")

    case results do
      "XMAS" -> 1
      _ -> 0
    end
  end

  # X-MAS SEARCH

  def count_x_mas(grid) do
    for x <- 1..grid.width, y <- 1..grid.height do
      coord = {x - 1, y - 1}

      case Grid.fetch(grid, coord) do
        {:ok, "A"} -> count_x_mas_from_cell(grid, coord)
        _ -> 0
      end
    end
    |> Enum.sum()
  end

  defp count_x_mas_from_cell(grid, origin) do
    is_x_mas =
      [
        [Grid.Cell.nw(origin), origin, Grid.Cell.se(origin)],
        [Grid.Cell.ne(origin), origin, Grid.Cell.sw(origin)]
      ]
      |> Enum.map(fn cells ->
        cells
        |> Enum.map(&Grid.at(grid, &1, "_"))
        |> Enum.join("")
      end)
      |> Enum.all?(&(&1 == "MAS" || &1 == "SAM"))

    if is_x_mas, do: 1, else: 0
  end
end
