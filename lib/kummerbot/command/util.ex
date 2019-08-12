defmodule Kummerbot.Command.Util do
  alias Nostrum.Api

  import Nostrum.Struct.Embed

  require Logger

  defp get_image_url(msg) do
    if List.first(msg.attachments) != nil do
      msg.attachments
      |> List.first()
      |> Map.get(:url)
    end
  end

  def mail(msg) do
    Api.create_message(msg.channel_id, "Thank you :slight_smile:")

    embedmsg =
      %Nostrum.Struct.Embed{}
      |> put_title("Anonymous")
      |> put_description(msg.content)
      |> put_color(Enum.random(1..16777215))
      |> put_image(get_image_url(msg))

    Api.create_message(Application.get_env(:kummerbot, :kummerchannel), embed: embedmsg)
  end
end
