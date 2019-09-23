defmodule Kummerbot.Command do
  alias Kummerbot.Command.Util

  @bot_id Application.get_env(:kummerbot, :bot_id)

  defp actionable_command?(msg) do
    msg.author.id != @bot_id
  end

  defp direct_message?(msg) do
    msg.guild_id == nil
  end

  def handle(msg) do
    if actionable_command?(msg) do
      if direct_message?(msg) do
        Util.mail(msg)
      end
    end
  end

  def execute(_any, _msg) do
    :noop
  end
end
