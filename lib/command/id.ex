defmodule Kummerbot.Command.Id do
  alias Nostrum.Api
  alias Kummerbot.Utils.Identity

  def get_id({%Nostrum.Struct.Message{} = msg, identity}) do
    Api.create_message(msg.channel_id,
      embed: %Nostrum.Struct.Embed{
        description: "Your ID is `@#{identity.nano_id}`",
        color: identity.color
      }
    )
  end

  def reset_id(%Nostrum.Struct.Message{} = msg) do
    case Identity.update_nanoid(msg.author) do
      {:ok, identity} ->
        Api.create_message(msg.channel_id,
          embed: %Nostrum.Struct.Embed{
            description: """
            ID was updated successfully :muscle:
            New ID: `@#{identity.nano_id}`
            """,
            color: identity.color
          }
        )

      {:error, identity} ->
        Api.create_message(msg.channel_id,
          embed: %Nostrum.Struct.Embed{
            description: "There was an error updating your ID. :pensive:",
            color: identity.color
          }
        )
    end
  end
end
