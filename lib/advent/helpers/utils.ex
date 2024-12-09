defmodule Advent.Helpers.Utils do
  def permutations(lst) when is_list(lst), do: do_permutations(lst, [])
  def permutations(lst), do: Enum.into(lst, []) |> permutations()

  defp do_permutations([], acc), do: acc

  defp do_permutations([head | rest], acc) do
    perms = Enum.map(rest, fn second -> {head, second} end)
    do_permutations(rest, acc ++ perms)
  end
end
