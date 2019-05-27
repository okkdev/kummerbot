defmodule Kummerbot.Command do
  alias Kummerbot.Command.Util

  @bot_id 582318656009011233

  defp actionable_command?(msg) do
    msg.author.id != @bot_id
  end

  def handle(msg) do
    if actionable_command?(msg) do
      Util.ping(msg)
    end
  end

  def execute(_any, _msg) do
    :noop
  end
end
