defmodule Kummerbot.Consumer.MessageCreate do
  alias Nostrum.Api
  alias Kummerbot.Command.{Mail, Help, Id}
  alias Kummerbot.Utils.Identity

  # ignore self and other bots
  def handle(%{author: %{bot: true}}), do: :noop

  # direct message command
  def handle(%{guild_id: nil} = msg) do
    {:ok, identity} = Identity.check_identity(msg.author)

    if String.starts_with?(msg.content, Application.get_env(:kummerbot, :prefix)) do
      case String.trim_leading(
             String.downcase(msg.content),
             Application.get_env(:kummerbot, :prefix)
           ) do
        "help" ->
          Help.send_help({msg, identity})

        "id" ->
          Id.get_id({msg, identity})

        "resetid" ->
          Id.reset_id(msg)

        _ ->
          Api.create_message(msg.channel_id,
            embed: %Nostrum.Struct.Embed{
              description: """
              Unknown command :triumph:
              Try `.help`
              """,
              color: identity.color
            }
          )
      end
    else
      Mail.send_mail({msg, identity})
    end
  end

  def handle(_), do: :noop
end
