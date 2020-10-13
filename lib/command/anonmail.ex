defmodule Kummerbot.Command.Anonmail do
  alias Nostrum.Api

  import Nostrum.Struct.Embed

  def mail(msg) do
    Api.create_message(Application.get_env(:kummerbot, :kummer_channel),
      embed: create_embed(msg.content, "Anonymous")
    )

    Api.create_message(msg.channel_id, "Sent! :love_letter:")
  end

  def feedback(msg) do
    content =
      msg.content
      |> String.slice(10..-1)

    Api.create_message(Application.get_env(:kummerbot, :feedback_channel),
      embed: create_embed(content, "Feedback")
    )

    Api.create_message(msg.channel_id, "Feedback submitted! :love_letter:")
  end

  defp create_embed(content, title) do
    embed =
      %Nostrum.Struct.Embed{}
      |> put_title(title)
      |> put_description(content)
      |> put_color(Enum.random(1..16_777_215))

    embed
  end
end
