defmodule Advent.Days.Day03 do
  alias Advent.Parsers.ComputerMemory

  def run(input) do
    muls =
      ComputerMemory.parse_basic(input)
      |> elem(1)

    total = Enum.reduce(muls, 0, fn {:mul, [x, y]}, acc -> acc + x * y end)
    IO.puts("Part 1: #{total}")

    instrs =
      ComputerMemory.parse_advanced(input)
      |> elem(1)

    total =
      Enum.reduce(instrs, {true, 0}, fn val, {enabled, total} ->
        case val do
          {:do, _} ->
            {true, total}

          {:dont, _} ->
            {false, total}

          {:mul, [x, y]} ->
            total = if enabled, do: total + x * y, else: total
            {enabled, total}
        end
      end)
      |> elem(1)

    IO.puts("Part 2: #{total}")
  end
end
