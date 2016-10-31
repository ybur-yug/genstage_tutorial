defmodule GenstageExample.Mixfile do
  use Mix.Project

  def project do
    [app: :genstage_example,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :postgrex],
     mod: {GenstageExample, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.12.1"},
      {:gen_stage, "~> 0.7"},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  defp package do
    [# These are the default files included in the package
     name: :postgrex,
     files: ["doc", "lib", "priv", "mix.exs", "README*", "README*"],
     maintainers: ["Robert Grayson"],
     description: "A simple genstage example - a task runner",
     licenses: ["DWTFYWPL"],
     links: %{"GitHub" => "https://github.com/ybur-yug/genstage_example",
              "Docs" => "http://elixirschool.com/"}]
  end
end
