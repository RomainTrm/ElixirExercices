defmodule Weather.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript_config(),
      name: "Weather",
      source_url: "https://github.com/RomainTrm/ElixirExercices"
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
      {:httpoison, "~> 1.6"},
      {:sweet_xml, "~> 0.6.6"}
    ]
  end

  defp escript_config do
    [
      main_module: Weather.CLI
    ]
  end
end
