defmodule Advent.Days.Day02 do
  use Advent.Day

  def run(input) do
    count = count_safe_reports(input)
    IO.puts("Part 1: #{count}")

    count = count_safe_reports(input, true)
    IO.puts("Part 2: #{count}")
  end

  def count_safe_reports(input, allow_unsafe \\ false) do
    reports = parse_reports(input)

    reports
    |> Enum.filter(&is_safe(&1, allow_unsafe))
    |> Enum.count()
  end

  def parse_reports(input) do
    String.split(input, "\n")
    |> Enum.map(&parse_report/1)
  end

  def parse_report(line) do
    String.split(line, " ")
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end

  def is_safe(report, allow_unsafe \\ false) do
    safe =
      Enum.reduce_while(report, {nil, nil}, fn next, {last_diff, last} ->
        if is_nil(last) do
          {:cont, {nil, next}}
        else
          diff = next - last

          same_sign =
            is_nil(last_diff) || (diff >= 0 && last_diff >= 0) || (diff < 0 && last_diff < 0)

          within_tolerance = abs(diff) >= 1 && abs(diff) <= 3

          case same_sign && within_tolerance do
            true ->
              {:cont, {diff, next}}

            false ->
              {:halt, false}
          end
        end
      end) != false

    case {safe, allow_unsafe} do
      {true, _} ->
        true

      {false, false} ->
        false

      {false, true} ->
        Enum.with_index(report)
        |> Enum.any?(fn {_val, index} -> List.delete_at(report, index) |> is_safe() end)
    end
  end
end
