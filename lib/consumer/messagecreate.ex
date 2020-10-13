defmodule Kummerbot.Consumer.MessageCreate do
  alias Kummerbot.Command.Anonmail

  def handle(%{author: %{bot: true}}), do: :noop

  def handle(%{guild_id: nil} = msg) do
    case String.split(String.downcase(msg.content)) do
      ["feedback:"] ->
        :noop

      ["feedback:" | _] ->
        Anonmail.feedback(msg)

      _ ->
        Anonmail.mail(msg)
    end
  end

  def handle(_), do: :noop
end
