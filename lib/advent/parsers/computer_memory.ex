defmodule Advent.Parsers.ComputerMemory do
  import NimbleParsec

  mul =
    ignore(string("mul("))
    |> integer(min: 1, max: 3)
    |> ignore(string(","))
    |> integer(min: 1, max: 3)
    |> ignore(string(")"))
    |> tag(:mul)

  term_do =
    ignore(string("do()"))
    |> tag(:do)

  term_dont =
    ignore(string("don't()"))
    |> tag(:dont)

  basic_term =
    choice([
      mul,
      ignore(utf8_string([], 1))
    ])

  advanced_term =
    choice([
      mul,
      term_do,
      term_dont,
      ignore(utf8_string([], 1))
    ])

  defparsec :parse_basic, repeat(basic_term)

  defparsec :parse_advanced, repeat(advanced_term)
end
