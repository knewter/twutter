defmodule Twutter.Tweet do
  defrecord TweetData, content: "", author: "", timestamp: {}

  def init(content, author, timestamp) do
    TweetData.new(content: content, author: author, timestamp: timestamp)
  end

  def pretty_print(tweet=TweetData[]) do
    author = String.rjust(tweet.author, 15)
    "#{author} > #{tweet.content}"
  end
  def pretty_print(_), do: ""
end
