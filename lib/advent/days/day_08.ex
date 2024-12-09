defmodule Advent.Days.Day08 do
  alias Advent.Helpers.Grid.Cell
  alias Advent.Helpers.Utils
  alias Advent.Helpers.Grid

  def run(input) do
    {grid, data} =
      input
      |> parse_input()

    antinodes = get_antinodes(grid, data)
    count = Enum.count(antinodes)
    IO.puts("Part 1: #{count}")

    antinodes = get_more_antinodes(grid, data)
    count = Enum.count(antinodes)
    IO.puts("Part 2: #{count}")
  end

  def parse_input(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "", trim: true)
      end)
      |> Grid.new()

    data =
      grid
      |> Grid.with_cell()
      |> Enum.reduce(%{}, fn {square, cell}, acc ->
        case square do
          "." ->
            acc

          letter ->
            Map.update(acc, letter, MapSet.new([cell]), fn set ->
              MapSet.put(set, cell)
            end)
        end
      end)

    {grid, data}
  end

  def get_antinodes(grid, data) do
    Enum.flat_map(data, fn {_freq, cells} ->
      perms = Utils.permutations(cells)

      Enum.flat_map(perms, fn {a, b} ->
        distance_a = Cell.distance(a, b)
        distance_b = Cell.distance(b, a)
        anti_a = Cell.add(a, distance_a)
        anti_b = Cell.add(b, distance_b)

        [anti_a, anti_b] |> Enum.filter(&Grid.in_bounds?(grid, &1))
      end)
    end)
    |> Enum.into(MapSet.new())
  end

  def get_more_antinodes(grid, data) do
    Enum.flat_map(data, fn {_freq, cells} ->
      perms = Utils.permutations(cells)

      Enum.flat_map(perms, fn {a, b} ->
        distance_a = Cell.distance(a, b)
        distance_b = Cell.distance(b, a)

        anti_a = cell_stream(grid, a, distance_a) |> Enum.into([])
        anti_b = cell_stream(grid, b, distance_b) |> Enum.into([])

        [anti_a, anti_b] |> List.flatten()
      end)
    end)
    |> Enum.into(MapSet.new())
  end

  def cell_stream(grid, cell, distance) do
    Stream.unfold(
      {grid, cell, distance},
      fn {grid, cell, distance} ->
        if Grid.in_bounds?(grid, cell) do
          next_cell = Cell.add(cell, distance)
          {cell, {grid, next_cell, distance}}
        else
          nil
        end
      end
    )
  end
end
