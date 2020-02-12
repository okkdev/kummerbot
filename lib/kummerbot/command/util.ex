defmodule Kummerbot.Command.Util do
  alias Nostrum.Api

  import Nostrum.Struct.Embed

  require Logger

  @alphabet Enum.to_list(?a..?z) ++ Enum.to_list(?0..?9)

  defp video_or_image(url) do
    # Expand list with supported video formats
    if String.ends_with?(url, [".mp4"]) do
      %{video: url}
    else
      %{image: url}
    end
  end

  defp get_attachment_url(msg) do
    if List.first(msg.attachments) != nil do
      msg.attachments
      |> List.first()
      |> Map.get(:url)
    end
  end

  defp add_attachment(%{video: url}, embed) do
    put_video(embed, url)
  end

  defp add_attachment(%{image: url}, embed) do
    put_image(embed, url)
  end

  defp put_attachment(embed, msg) do
    url = get_attachment_url(msg)

    if url === nil do
      embed
    else
      url
      |> video_or_image
      |> add_attachment(embed)
    end
  end

  def mail(msg) do
    Api.create_message(msg.channel_id, "Thank you :slight_smile:")

    id = "@" <> to_string(Enum.map(1..5, fn _ -> Enum.random(@alphabet) end))

    [name, content] =
      if String.starts_with?(msg.content, "!") do
        msg.content
        |> String.trim()
        |> String.trim_leading("!")
        |> String.split(" ", parts: 2)
      else
        ["Anonymous", msg.content]
      end

    embedmsg =
      %Nostrum.Struct.Embed{}
      |> put_title(name)
      |> put_description(content)
      |> put_color(Enum.random(1..16_777_215))
      |> put_attachment(msg)
      |> put_footer(id)

    Api.create_message(Application.get_env(:kummerbot, :kummerchannel), embed: embedmsg)

    if embedmsg.video do
      Api.create_message(Application.get_env(:kummerbot, :kummerchannel),
        content: id <> " Video: " <> embedmsg.video.url
      )
    end
  end
end
