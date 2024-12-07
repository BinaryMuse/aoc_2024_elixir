defmodule Advent.Days.Day07Test do
  use ExUnit.Case, async: true

  alias Advent.Days.Day07

  @test_input """
              190: 10 19
              3267: 81 40 27
              83: 17 5
              156: 15 6
              7290: 6 8 6 15
              161011: 16 10 13
              192: 17 8 14
              21037: 9 7 18 13
              292: 11 6 16 20
              """
              |> String.trim()
              |> Day07.parse_input()

  test "finds operators" do
    equation = {190, [10, 19]}
    possible_ops = [:add, :mul]

    assert Day07.get_solutions(equation, possible_ops) == [{true, [:mul]}]
  end

  test "finds multiple operators" do
    equation = {292, [11, 6, 16, 20]}
    possible_ops = [:add, :mul]

    assert Day07.get_solutions(equation, possible_ops) == [{true, [:add, :mul, :add]}]
  end

  test "solves part 1" do
    assert Day07.part1(@test_input) == 3749
  end

  test "solves part 2" do
    assert Day07.part2(@test_input) == 11387
  end
end
