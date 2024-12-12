defmodule Advent.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_parsec, "~> 1.4.0"},
      {:arrays, "~> 2.1"},
      {:arrays_aja, "~> 0.2.0"},
      {:igniter, "~> 0.4.8"}
    ]
  end

  defp aliases() do
    [
      setup: ["deps.get", "deps.compile"]
    ]
  end
end
