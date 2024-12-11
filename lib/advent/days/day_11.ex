defmodule Advent.Days.Day11 do
  def run(input) do
    stream = parse(input) |> make_stream()

    count = stream |> Stream.drop(24) |> Enum.take(1) |> hd() |> count_stones()
    IO.puts("Part 1: #{count}")

    count = stream |> Stream.drop(74) |> Enum.take(1) |> hd() |> count_stones()
    IO.puts("Part 2: #{count}")
  end

  def parse(input) do
    String.split(input, " ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def make_stream(stones) do
    Stream.iterate(Enum.frequencies(stones), &blink/1)
    # skip the initial arrangement
    |> Stream.drop(1)
  end

  defp blink(stones) do
    Enum.reduce(stones, %{}, &process_stone/2)
  end

  defp process_stone({stone, count}, next_acc) do
    str = "#{stone}"
    len = String.length(str)

    transform =
      cond do
        stone == 0 ->
          [1]

        rem(len, 2) == 0 ->
          half = div(len, 2)
          left = String.slice(str, 0, half) |> String.to_integer()
          right = String.slice(str, half, half) |> String.to_integer()
          [left, right]

        true ->
          [stone * 2024]
      end

    Enum.reduce(transform, next_acc, fn stone, acc ->
      Map.update(acc, stone, count, &(&1 + count))
    end)
  end

  def count_stones(stones) do
    Map.values(stones) |> Enum.sum()
  end
end
