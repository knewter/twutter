defmodule Twutter do
  use Application.Behaviour

  defrecord Authentication, consumer_key: nil, consumer_secret: nil, access_token: nil, access_token_secret: nil

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Twutter.Supervisor.start_link
  end

  def api_root do
    "https://api.twitter.com/"
  end

  def versioned_api_root do
    api_root <> "1.1/"
  end

  def request_token_url do
    api_root <> "oauth/request_token"
  end

  def authorize_url do
    api_root <> "oauth/authorize"
  end

  def access_token_url do
    api_root <> "oauth/access_token"
  end

  def home_timeline_url do
    versioned_api_root <> "statuses/home_timeline.json"
  end

  def favorites_url do
    versioned_api_root <> "favorites/list.json"
  end
end
