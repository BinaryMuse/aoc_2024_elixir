defmodule Advent.Days.Day10 do
  alias Advent.Helpers.Grid
  alias Advent.Helpers.Grid.Cell

  def run(input) do
    scores = parse_input(input) |> find_trails() |> total_scores()
    IO.puts("Part 1: #{scores}")

    ratings = parse_input(input) |> find_trails() |> total_ratings()
    IO.puts("Part 2: #{ratings}")
  end

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, "", trim: true) |> Enum.map(&String.to_integer/1)
    end)
    |> Grid.new()
  end

  def find_trails(map) do
    Grid.with_cell(map)
    |> Enum.reduce([], fn {item, cell}, acc ->
      if item == 0, do: [cell | acc], else: acc
    end)
    |> Map.new(fn trailhead ->
      {trailhead, do_find_trails(trailhead, map, [trailhead])}
    end)
  end

  defp do_find_trails(pos, map, acc) do
    elevation = Grid.at(map, pos)

    if elevation == 9 do
      [acc] |> Enum.reverse()
    else
      [:north, :south, :east, :west]
      |> Stream.map(fn dir -> apply(Cell, dir, [pos]) end)
      |> Stream.filter(&Grid.in_bounds?(map, &1))
      |> Stream.filter(&(Grid.at(map, &1) == elevation + 1))
      |> Stream.flat_map(&do_find_trails(&1, map, [&1 | acc]))
    end
  end

  def total_scores(trails) do
    Enum.map(trails, fn {_trailhead, trails} ->
      MapSet.new(trails, fn [final | _rest] -> final end)
    end)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end

  def total_ratings(trails) do
    Enum.flat_map(trails, &elem(&1, 1)) |> Enum.count()
  end
end
