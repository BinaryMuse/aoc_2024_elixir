defmodule Mix.Tasks.Day do
  use Mix.Task

  def run(args) do
    day = args |> hd() |> Advent.normalize_day()
    input = Advent.get_input(day)

    Advent.run_day(day, input)
  end
end
