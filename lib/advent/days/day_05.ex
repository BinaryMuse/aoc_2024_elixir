defmodule Advent.Days.Day05 do
  def run(input) do
    {rules, updates} = parse_input(input)

    sum = part1(rules, updates)
    IO.puts("Part 1: #{sum}")

    sum = part2(rules, updates)
    IO.puts("Part 2: #{sum}")
  end

  def part1(rules, updates) do
    updates
    |> Enum.filter(&valid_update?(&1, rules))
    |> Enum.map(&find_middle/1)
    |> Enum.sum()
  end

  def part2(rules, updates) do
    updates
    |> Enum.reject(&valid_update?(&1, rules))
    |> Enum.map(&fix_order(&1, rules))
    |> Enum.map(&find_middle/1)
    |> Enum.sum()
  end

  def parse_input(input) do
    [rules, updates] = String.split(input, "\n\n")

    rules =
      String.split(rules, "\n")
      |> Enum.map(fn line ->
        String.split(line, "|")
        |> Enum.map(&String.to_integer/1)
      end)
      |> compile_rules()

    updates =
      String.split(updates, "\n")
      |> Enum.map(fn line ->
        String.split(line, ",")
        |> Enum.map(&String.to_integer/1)
      end)

    {rules, updates}
  end

  def compile_rules(pairs) do
    Enum.reduce(pairs, %{}, fn [first, second], acc ->
      acc
      |> Map.update(second, MapSet.new([first]), fn set ->
        MapSet.put(set, first)
      end)
    end)
  end

  def valid_update?(update, rules) do
    used = Enum.into(update, MapSet.new())
    acc = %{used: used, seen: MapSet.new(), valid: true}

    %{valid: valid} =
      Enum.reduce(update, acc, fn val, acc ->
        valid =
          Map.get(rules, val, MapSet.new())
          |> Enum.filter(&MapSet.member?(acc.used, &1))
          |> Enum.all?(&MapSet.member?(acc.seen, &1))

        seen = MapSet.put(acc.seen, val)
        valid = valid && acc.valid
        %{acc | seen: seen, valid: valid}
      end)

    valid
  end

  def find_middle(list) do
    idx =
      div(Enum.count(list) - 1, 2)

    Enum.at(list, idx)
  end

  def fix_order(update, rules) do
    used = Enum.into(update, MapSet.new())
    acc = %{used: used, seen: MapSet.new(), list: []}

    %{list: list} =
      update
      |> Enum.reduce(acc, fn _val, acc ->
        next =
          Enum.filter(MapSet.difference(acc.used, acc.seen), fn potential ->
            preconditions =
              Map.get(rules, potential, MapSet.new())
              |> MapSet.intersection(used)

            MapSet.intersection(preconditions, acc.seen) == preconditions
          end)
          |> hd()

        used = MapSet.put(acc.used, next)
        seen = MapSet.put(acc.seen, next)
        list = [next | acc.list]
        %{acc | used: used, seen: seen, list: list}
      end)

    Enum.reverse(list)
  end
end
