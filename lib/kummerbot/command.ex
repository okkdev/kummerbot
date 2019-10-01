defmodule Kummerbot.Command do
  alias Kummerbot.Command.Util

  @bot_id Application.get_env(:kummerbot, :bot_id)

  defguardp is_actionable_command(msg) when msg.author.id != @bot_id
  defguardp is_direct_message(msg) when msg.guild_id == nil

  def handle(msg) when is_actionable_command(msg) and is_direct_message(msg) do
    Util.mail(msg)
  end

  def execute(_any, _msg) do
    :noop
  end
end
