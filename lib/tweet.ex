defmodule Twutter.Tweet do
  defrecord TweetData,
    id: nil,
    favorited: false,
    retweeted: false,
    author: "",
    timestamp: {},
    lang: "",
    coordinates: nil,
    source: "",
    created_at: nil,
    text: ""

  def parse(tweet_hashdict) do
    TweetData.new(
      coordinates: tweet_hashdict["coordinates"],
      lang: tweet_hashdict["lang"],
      id: tweet_hashdict["id_str"],
      source: tweet_hashdict["source"],
      favorited: tweet_hashdict["favorited"],
      retweeted: tweet_hashdict["retweeted"],
      created_at: tweet_hashdict["created_at"],
      text: tweet_hashdict["text"]
    )
  end

  def init(text, author, timestamp) do
    TweetData.new(text: text, author: author, timestamp: timestamp)
  end

  def pretty_print(tweet=TweetData[]) do
    author = String.rjust(tweet.author, 15)
    "#{author} > #{tweet.text}"
  end
  def pretty_print(_), do: ""
end
