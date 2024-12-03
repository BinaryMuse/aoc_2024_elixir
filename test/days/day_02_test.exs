defmodule Advent.Days.Day02Test do
  use ExUnit.Case, async: true

  alias Advent.Days.Day02

  @test_input """
              7 6 4 2 1
              1 2 7 8 9
              9 7 6 2 1
              1 3 2 4 5
              8 6 4 4 1
              1 3 6 7 9
              """
              |> String.trim()

  test "counts safe reports" do
    assert Day02.count_safe_reports(@test_input) == 2
  end

  test "counts safe reports within tolerance" do
    assert Day02.count_safe_reports(@test_input, true) == 4
  end
end
