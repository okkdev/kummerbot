defmodule Kummerbot.Command.Id do
  alias Nostrum.Api
  alias Kummerbot.Utils.Identity

  def get_id(%Nostrum.Struct.Message{} = msg) do
    id = Identity.get_identity!(msg.author)

    Api.create_message(msg.channel_id,
      embed: %Nostrum.Struct.Embed{
        description: "Your ID is `@#{id.nano_id}`",
        color: Application.get_env(:kummerbot, :embed_color)
      }
    )
  end

  def reset_id(%Nostrum.Struct.Message{} = msg) do
    case Identity.update_nanoid(msg.author) do
      {:ok, id} ->
        Api.create_message(msg.channel_id,
          embed: %Nostrum.Struct.Embed{
            description: """
            ID was updated successfully :muscle:
            New ID: `@#{id.nano_id}`
            """,
            color: Application.get_env(:kummerbot, :embed_color)
          }
        )

      {:error, _} ->
        Api.create_message(msg.channel_id,
          embed: %Nostrum.Struct.Embed{
            description: "There was an error updating your ID. :pensive:",
            color: Application.get_env(:kummerbot, :embed_color)
          }
        )
    end
  end
end
