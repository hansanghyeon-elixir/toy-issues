defmodule ToyIssues.MixProject do
  use Mix.Project

  def project do
    [
      app: :toy_issues,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      name: "Issues",
      source_url: "https://github.com/hansanghyeon-elixir/toy-issues",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      deps: deps()
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
      {:httpoison, "~> 1.0"},
      {:poison, "~> 6.0"},
      {:ex_doc, "~> 0.35"},
      {:earmark, "~> 1.4.47"},
      {:excoveralls, "~> 0.18.3", only: :test}
    ]
  end

  defp escript_config do
    [
      main_module: ToyIssues.CLI
    ]
  end
end
