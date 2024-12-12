defmodule Mix.Tasks.Advent.Gen.Day do
  use Igniter.Mix.Task

  @example "mix advent.gen.day <number>"

  @shortdoc "Generate the files for a new Advent of Code day"
  @moduledoc """
  #{@shortdoc}

  Longer explanation of your task

  ## Example

  ```bash
  #{@example}
  ```

  ## Options

  * `--example-option` or `-e` - Docs for your option
  """

  @impl Igniter.Mix.Task
  def info(_argv, _composing_task) do
    %Igniter.Mix.Task.Info{
      # Groups allow for overlapping arguments for tasks by the same author
      # See the generators guide for more.
      group: :advent,
      # dependencies to add
      adds_deps: [],
      # dependencies to add and call their associated installers, if they exist
      installs: [],
      # An example invocation
      example: @example,
      # a list of positional arguments, i.e `[:file]`
      positional: [],
      # Other tasks your task composes using `Igniter.compose_task`, passing in the CLI argv
      # This ensures your option schema includes options from nested tasks
      composes: [],
      # `OptionParser` schema
      schema: [],
      # Default values for the options in the `schema`
      defaults: [],
      # CLI aliases
      aliases: [],
      # A list of options in the schema that are required
      required: []
    }
  end

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    [day | _] = igniter.args.argv

    day =
      if String.length(day) < 2 do
        "0#{day}"
      else
        day
      end

    mod_path = Path.join(["lib", "advent", "days", "day_#{day}.ex"])
    test_path = Path.join(["test", "days", "day_#{day}_test.exs"])

    igniter
    |> Igniter.create_new_file(mod_path, """
    defmodule Advent.Days.Day#{day} do
      use Advent.Day

      def run(input) do
        #
      end
    end
    """)
    |> Igniter.create_new_file(test_path, """
    defmodule Days.Day#{day}Test do
      use ExUnit.Case, async: true

      alias Advent.Days.Day#{day}

      test "things" do
        assert true == true
      end
    end
    """)
  end
end
