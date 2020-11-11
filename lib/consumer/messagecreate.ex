defmodule Kummerbot.Consumer.MessageCreate do
  alias Kummerbot.Command.Mailer

  # ignore self and other bots
  def handle(%{author: %{bot: true}}), do: :noop

  # direct message
  def handle(%{guild_id: nil} = msg) do
    Mailer.mail(msg)
  end

  def handle(_), do: :noop
end
