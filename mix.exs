defmodule Clockwork.MixProject do
  use Mix.Project

  def project do
    [
      app: :clockwork,
      version: "0.1.0",
      elixir: "~> 1.11-rc",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :wx],
      mod: {Clockwork.Application, []}
    ]
  end

  defp deps do
    []
  end
end
