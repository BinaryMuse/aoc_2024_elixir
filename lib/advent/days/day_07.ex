defmodule Advent.Days.Day07 do
  use Advent.Day

  def run(input) do
    equations = parse_input(input)

    sum = part1(equations)
    IO.puts("Part 1: #{sum}")

    sum = part2(equations)
    IO.puts("Part 2: #{sum}")
  end

  def part1(equations), do: equations |> solve([:add, :mul])
  def part2(equations), do: equations |> solve([:add, :mul, :concat])

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ": "))
    |> Enum.map(fn [left, right] ->
      left = String.to_integer(left)
      right = String.split(right, " ") |> Enum.map(&String.to_integer/1)
      {left, right}
    end)
  end

  def solve(equations, possible_ops) do
    equations
    |> Task.async_stream(fn {result, _nums} = eq ->
      {result, get_solutions(eq, possible_ops)}
    end)
    |> Stream.map(&elem(&1, 1))
    |> Stream.filter(fn {_result, lst} -> Enum.count(lst) > 0 end)
    |> Stream.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def get_solutions({result, [val | rest]}, possible_ops) do
    try_solve({result, rest}, possible_ops, {val, []})
    |> Enum.filter(fn {solved, _ops} -> solved end)
  end

  defp try_solve({result, []}, _possible_ops, {running_total, ops}) do
    [{running_total == result, Enum.reverse(ops)}]
  end

  defp try_solve({result, [value | rest]}, possible_ops, {running_total, ops}) do
    Enum.flat_map(possible_ops, fn op ->
      new_ops = [op | ops]
      try_solve({result, rest}, possible_ops, {do_op(running_total, value, op), new_ops})
    end)
  end

  defp do_op(left, right, :add), do: left + right
  defp do_op(left, right, :mul), do: left * right
  defp do_op(left, right, :concat), do: "#{left}#{right}" |> String.to_integer()
end
