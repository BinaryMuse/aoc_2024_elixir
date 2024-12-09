defmodule Days.Day09Test do
  use ExUnit.Case, async: true

  import Advent.Days.Day09

  test "parses a disk map" do
    map = "12345"
    assert parse_map(map) |> mem_to_string() == "0..111....22222"

    map = "2333133121414131402"

    assert parse_map(map) |> mem_to_string() ==
             "00...111...2...333.44.5555.6666.777.888899"
  end

  test "compacts memory" do
    map = "12345"

    assert parse_map(map) |> compact_memory() |> mem_to_string() ==
             "022111222......"
  end

  test "compacts whole files" do
    map = "2333133121414131402"

    assert parse_map(map) |> compact_files() |> mem_to_string() ==
             "00992111777.44.333....5555.6666.....8888.."
  end

  test "calculates checksum" do
    map = "2333133121414131402"

    assert parse_map(map) |> compact_memory() |> calculate_checksum() == 1928
  end
end
