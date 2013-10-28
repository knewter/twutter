defmodule Twutter do
  use Application.Behaviour

  defrecord Authentication, consumer_key: nil, consumer_secret: nil, access_token: nil, access_token_secret: nil

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Twutter.Supervisor.start_link
  end

  def api_root do
    "https://api.twitter.com/1.1/"
  end

  def home_timeline_url do
    api_root <> "statuses/home_timeline.json"
  end
end
