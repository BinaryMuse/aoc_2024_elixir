defmodule Advent.Day do
  defmacro __using__(_opts \\ []) do
    quote do
      @behaviour Advent.Day
    end
  end

  @callback run(input :: binary) :: any
end
