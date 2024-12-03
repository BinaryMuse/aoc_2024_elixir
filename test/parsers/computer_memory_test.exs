defmodule Advent.Parsers.ComputerMemoryTest do
  use ExUnit.Case, async: true

  alias Advent.Parsers.ComputerMemory

  @test_input """
              xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
              """
              |> String.trim()

  @advanced_input """
                  xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
                  """
                  |> String.trim()

  test "parses basic computer memory" do
    result = ComputerMemory.parse_basic(@test_input)
    assert elem(result, 0) == :ok
    assert elem(result, 1) == [mul: [2, 4], mul: [5, 5], mul: [11, 8], mul: [8, 5]]
  end

  test "parses advanced computer memory" do
    result = ComputerMemory.parse_advanced(@advanced_input)
    assert elem(result, 0) == :ok

    assert elem(result, 1) == [
             mul: [2, 4],
             dont: [],
             mul: [5, 5],
             mul: [11, 8],
             do: [],
             mul: [8, 5]
           ]
  end
end
