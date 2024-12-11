defmodule Days.Day11Test do
  use ExUnit.Case, async: true

  alias Advent.Days.Day11

  test "generates a stream of stone arrangements" do
    input = [125, 17]

    count =
      Day11.make_stream(input)
      |> Stream.drop(24)
      |> Enum.take(1)
      |> hd()
      |> Day11.count_stones()

    assert count == 55312
  end
end
