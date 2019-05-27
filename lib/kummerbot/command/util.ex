defmodule Kummerbot.Command.Util do
  alias Nostrum.Api

  require Logger

  def ping(msg) do
    Api.create_message(msg.channel_id, "pong")
  end
end
