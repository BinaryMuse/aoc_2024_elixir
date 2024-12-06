defmodule Advent.Days.Day05Test do
  use ExUnit.Case, async: true

  alias Advent.Days.Day05

  @test_input """
              47|53
              97|13
              97|61
              97|47
              75|29
              61|13
              75|53
              29|13
              97|29
              53|29
              61|53
              97|53
              61|29
              47|13
              75|47
              97|75
              47|61
              75|61
              47|29
              75|13
              53|13

              75,47,61,53,29
              97,61,53,29,13
              75,29,13
              75,97,47,61,53
              61,13,29
              97,13,75,29,47
              """
              |> String.trim()
              |> Day05.parse_input()

  test "calculates good updates" do
    {rules, updates} = @test_input

    assert Day05.part1(rules, updates) == 143
  end

  test "calculates bad updates" do
    {rules, updates} = @test_input

    assert Day05.part2(rules, updates) == 123
  end
end
