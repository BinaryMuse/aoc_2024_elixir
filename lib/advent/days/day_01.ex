defmodule Advent.Days.Day01 do
  def run(input) do
    [left, right] =
      String.split(input, "\n")
      |> Enum.map(&split_line/1)
      |> Enum.reduce([[], []], fn {next_l, next_r}, [left, right] ->
        left = [next_l | left]
        right = [next_r | right]

        [left, right]
      end)
      |> Enum.map(&Enum.sort/1)

    diff =
      Enum.zip_reduce([left, right], 0, fn [next_l, next_r], acc ->
        diff = abs(next_l - next_r)
        acc + diff
      end)

    IO.puts("Part 1: #{diff}")

    frequencies = calc_freq(right)

    score =
      Enum.reduce(left, 0, fn next, acc ->
        acc + next * Map.get(frequencies, next, 0)
      end)

    IO.puts("Part 2: #{score}")
  end

  def split_line(line) do
    regex = ~r/\A(\d+)\s+(\d+)\z/

    [[_match, left, right]] = Regex.scan(regex, line)
    {left, _} = Integer.parse(left)
    {right, _} = Integer.parse(right)

    {left, right}
  end

  def calc_freq(list, acc \\ %{})
  def calc_freq([], acc), do: acc

  def calc_freq([head | rest], acc) do
    acc = Map.update(acc, head, 1, &(&1 + 1))
    calc_freq(rest, acc)
  end
end
