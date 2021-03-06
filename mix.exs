defmodule Twutter.Mixfile do
  use Mix.Project

  def project do
    [ app: :twutter,
      version: "0.0.1",
      elixir: "~> 0.11",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [
        :crypto,
        :asn1,
        :public_key,
        :ssl,
        :inets
      ],
      mod: { Twutter, [] }
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      { :oauth, github: "tim/erlang-oauth" },
      { :json, github:  "cblage/elixir-json" }
    ]
  end
end
