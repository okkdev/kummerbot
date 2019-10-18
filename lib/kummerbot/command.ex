defmodule Kummerbot.Command do
  alias Kummerbot.Command.Util

  @bot_id Application.get_env(:kummerbot, :bot_id)

  defguardp is_actionable_command(id) when id != @bot_id

  def handle(%{author: %{id: author_id}, guild_id: nil} = msg)
      when is_actionable_command(author_id) do
    Util.mail(msg)
  end

  def handle(_), do: nil

  def execute(_any, _msg) do
    :noop
  end
end
