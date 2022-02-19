defmodule LiveSlide.MixProject do
  use Mix.Project

  def project do
    [
      app: :live_slide,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
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
      {:kino, github: "livebook-dev/kino"}
    ]
  end

  defp description() do
    "A custom Kino slide component for livebook"
  end

  def package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/BrooklinJazz/live_slide"}
    ]
  end
end
