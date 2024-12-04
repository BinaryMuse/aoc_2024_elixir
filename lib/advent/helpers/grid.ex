defmodule Advent.Helpers.Grid do
  @doc """
  The `Grid` struct represents a two dimensional array. Note that the origin,
  `{0, 0}`, starts at the upper left corner.

  Every array inside the outer array must be the same length; behavior is
  undefined if inner arrays are different lengths.
  """
  defstruct rows: [[]], width: 0, height: 0

  def new(rows \\ [[]]) do
    %__MODULE__{} |> set_rows(rows)
  end

  def at(%__MODULE__{rows: rows} = grid, {x, y}, default \\ nil) do
    case in_bounds?(grid, {x, y}) do
      true ->
        rows
        |> Enum.at(y, [])
        |> Enum.at(x, default)

      false ->
        default
    end
  end

  def fetch(%__MODULE__{} = grid, {x, y}) do
    case in_bounds?(grid, {x, y}) do
      false ->
        :error

      true ->
        {:ok, at(grid, {x, y})}
    end
  end

  def in_bounds?(%__MODULE__{width: w, height: h}, {x, y}) do
    x >= 0 && y >= 0 && x < w && y < h
  end

  defp set_rows(%__MODULE__{} = grid, rows) do
    height = Enum.count(rows)
    width = List.first(rows) |> Enum.count()

    %{grid | rows: rows, width: width, height: height}
  end

  defmodule Cell do
    def east({x, y}, steps \\ 1), do: {x + steps, y}
    def west({x, y}, steps \\ 1), do: {x - steps, y}
    def north({x, y}, steps \\ 1), do: {x, y - steps}
    def south({x, y}, steps \\ 1), do: {x, y + steps}

    def ne(cell, steps \\ 1), do: cell |> north(steps) |> east(steps)
    def nw(cell, steps \\ 1), do: cell |> north(steps) |> west(steps)
    def se(cell, steps \\ 1), do: cell |> south(steps) |> east(steps)
    def sw(cell, steps \\ 1), do: cell |> south(steps) |> west(steps)
  end
end
