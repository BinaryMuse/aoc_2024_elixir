defmodule Helpers.UtilTest do
  use ExUnit.Case, async: true

  alias Advent.Helpers.Utils

  test "permutations" do
    assert Utils.permutations([1, 2, 3]) == [{1, 2}, {1, 3}, {2, 3}]
  end
end
