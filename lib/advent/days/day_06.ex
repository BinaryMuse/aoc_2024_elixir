defmodule Advent.Days.Day06 do
  use Advent.Day

  alias Advent.Helpers.Grid.Cell
  alias Advent.Helpers.Grid

  def run(input) do
    count = part1(input)
    IO.puts("Part 1: #{count}")

    count = part2(input)
    IO.puts("Part 2: #{count}")
  end

  def part1(input) do
    {room, cell, direction} = parse_input(input)

    path_stream(room, cell, direction)
    |> Enum.reduce(MapSet.new(), fn {_room, cell, _dir}, set -> MapSet.put(set, cell) end)
    |> Enum.count()
  end

  def part2(input) do
    {room, cell, direction} = parse_input(input)

    path_stream(room, cell, direction)
    |> Enum.reduce(MapSet.new(), fn {_room, cell, _dir}, set -> MapSet.put(set, cell) end)
    |> Task.async_stream(&creates_infinite_loop?(room, cell, direction, &1))
    |> Stream.filter(&match?({:ok, true}, &1))
    |> Enum.count()
  end

  def parse_input(input) do
    room =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "", trim: true)
        |> Enum.map(&parse_square/1)
      end)
      |> Grid.new()

    {{:guard, direction}, cell} =
      Grid.with_cell(room)
      |> Enum.find(fn {item, _cell} -> is_tuple(item) end)

    {room, cell, direction}
  end

  def path_stream(room, cell, direction) do
    Stream.unfold(
      {room, cell, direction},
      fn {room, cell, direction} ->
        if Grid.in_bounds?(room, cell) do
          {next_cell, next_direction} = get_next_cell(room, cell, direction)

          next_room =
            room
            |> Grid.put(cell, :empty)
            |> Grid.put(next_cell, {:guard, next_direction})

          {{room, cell, direction}, {next_room, next_cell, next_direction}}
        else
          nil
        end
      end
    )
  end

  def get_next_cell(room, cell, direction) do
    next_cell = apply(Cell, direction, [cell])

    case Grid.fetch(room, next_cell) do
      {:ok, :empty} -> {next_cell, direction}
      {:ok, :obstacle} -> get_next_cell(room, cell, turn(direction, :right))
      :error -> {next_cell, direction}
    end
  end

  def creates_infinite_loop?(room, cell, direction, obst_cell) do
    new_room = Grid.put(room, obst_cell, :obstacle)
    seen = MapSet.new()

    result =
      path_stream(new_room, cell, direction)
      |> Enum.reduce_while(seen, fn {_room, check_cell, check_direction}, seen ->
        case MapSet.member?(seen, {check_cell, check_direction}) do
          true -> {:halt, true}
          false -> {:cont, MapSet.put(seen, {check_cell, check_direction})}
        end
      end)

    result == true
  end

  def parse_square(square) do
    case square do
      "." -> :empty
      "#" -> :obstacle
      g -> {:guard, parse_direction(g)}
    end
  end

  def parse_direction("^"), do: :north
  def parse_direction("v"), do: :south
  def parse_direction(">"), do: :east
  def parse_direction("<"), do: :west

  def turn(:north, :right), do: :east
  def turn(:east, :right), do: :south
  def turn(:south, :right), do: :west
  def turn(:west, :right), do: :north
end
