defmodule Kummerbot.MixProject do
  use Mix.Project

  def project do
    [
      app: :kummerbot,
      version: "0.2.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Kummerbot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nostrum, "~> 0.4.1"},
      {:httpoison, "~> 1.6"}
    ]
  end
end
