defmodule Days.Day10Test do
  use ExUnit.Case, async: true

  alias Advent.Days.Day10

  @test_input """
              89010123
              78121874
              87430965
              96549874
              45678903
              32019012
              01329801
              10456732
              """
              |> String.trim()

  test "calculates trails scores" do
    assert @test_input |> Day10.parse_input() |> Day10.find_trails() |> Day10.total_scores() == 36
  end

  test "calculates trails ratings" do
    assert @test_input |> Day10.parse_input() |> Day10.find_trails() |> Day10.total_ratings() ==
             81
  end
end
