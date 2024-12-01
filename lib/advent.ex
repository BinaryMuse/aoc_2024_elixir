defmodule Advent do
  def run_day(day, input) do
    mod = "Elixir.Advent.Days.Day#{day}" |> String.to_atom()
    apply(mod, :run, [input])
  end

  def get_input(day) do
    file = "day_#{day}.txt"
    File.read!("./inputs/#{file}")
  end

  def normalize_day(day) when is_integer(day), do: normalize_day("#{day}")
  def normalize_day(day) when is_binary(day), do: String.pad_leading(day, 2, "0")
end
