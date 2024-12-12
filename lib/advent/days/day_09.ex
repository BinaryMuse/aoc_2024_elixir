defmodule Advent.Days.Day09 do
  use Advent.Day

  def run(input) do
    checksum = parse_map(input) |> compact_memory() |> calculate_checksum()
    IO.puts("Day 1: #{checksum}")

    checksum = parse_map(input) |> compact_files() |> calculate_checksum()
    IO.puts("Day 2: #{checksum}")
  end

  def parse_map(map) do
    String.split(map, "", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {num, idx} ->
      elem =
        case rem(idx, 2) do
          0 -> div(idx, 2)
          1 -> :empty
        end

      Stream.cycle([elem]) |> Enum.take(num)
    end)
  end

  def compact_memory(memory) do
    memory
    |> Arrays.new(implementation: Aja.Vector)
    |> do_compact_memory()
  end

  def do_compact_memory(memory) do
    rev = Enum.reverse(memory)

    first_empty = Enum.find_index(memory, fn elem -> elem == :empty end)
    first_block = Arrays.size(memory) - 1 - Enum.find_index(rev, fn elem -> elem != :empty end)

    if first_empty > first_block do
      memory
    else
      block = Enum.at(memory, first_block)

      memory
      |> Arrays.replace(first_block, :empty)
      |> Arrays.replace(first_empty, block)
      |> do_compact_memory()
    end
  end

  def compact_files(memory) do
    memory
    |> Enum.chunk_by(fn x -> x end)
    |> Arrays.new(implementation: Aja.Vector)
    |> do_compact_files()
  end

  def do_compact_files(chunks, moved \\ MapSet.new()) do
    rev = Enum.reverse(chunks)

    file_loc =
      Enum.find_index(rev, fn lst ->
        case Enum.count(moved) do
          0 ->
            hd(lst) != :empty

          _ ->
            hd(lst) != :empty && hd(lst) < Enum.min(moved)
        end
      end) || 0

    file_loc = Arrays.size(chunks) - 1 - file_loc

    file = Arrays.get(chunks, file_loc)

    empty_loc =
      Enum.find_index(chunks, fn lst ->
        hd(lst) == :empty && Enum.count(lst) >= Enum.count(file)
      end)

    cond do
      Enum.count(moved) > 0 && Enum.min(moved) == 0 ->
        chunks |> Arrays.to_list() |> List.flatten()

      empty_loc != nil && file_loc != nil && empty_loc < file_loc ->
        space = Arrays.get(chunks, empty_loc)
        leftover_space_size = Enum.count(space) - Enum.count(file)
        leftover_space = Enum.take(space, leftover_space_size)

        empty_chunk = Stream.cycle([:empty]) |> Enum.take(Enum.count(file))

        chunks =
          chunks
          |> Arrays.replace(file_loc, empty_chunk)
          |> Arrays.replace(empty_loc, file)

        chunks =
          if leftover_space_size > 0 do
            left = Arrays.slice(chunks, 0..empty_loc)
            right = Arrays.slice(chunks, (empty_loc + 1)..Arrays.size(chunks))
            Arrays.concat([left, [leftover_space], right])
          else
            chunks
          end

        do_compact_files(chunks, MapSet.put(moved, hd(file)))

      true ->
        do_compact_files(chunks, MapSet.put(moved, hd(file)))
    end
  end

  def calculate_checksum(memory) do
    Enum.with_index(memory)
    |> Enum.map(fn {elem, idx} ->
      case elem do
        :empty -> 0
        num -> num * idx
      end
    end)
    |> Enum.sum()
  end

  def mem_to_string(memory), do: Enum.map(memory, &elem_to_string/1) |> Enum.join("")
  defp elem_to_string(:empty), do: "."
  defp elem_to_string(num) when is_integer(num), do: "#{num}"
end
