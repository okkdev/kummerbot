defmodule Kummerbot.Command.Util do
  alias Nostrum.Api

  import Nostrum.Struct.Embed

  require Logger

  @alphabet Enum.to_list(?a..?z) ++ Enum.to_list(?0..?9)

  defp get_image_url(msg) do
    if List.first(msg.attachments) != nil do
      msg.attachments
      |> List.first()
      |> Map.get(:url)
    end
  end

  def mail(msg) do
    Api.create_message(msg.channel_id, "Thank you :slight_smile:")

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
      |> put_image(get_image_url(msg))
      |> put_footer("#" <> to_string(Enum.map(1..5, fn _ -> Enum.random(@alphabet) end)))

    Api.create_message(Application.get_env(:kummerbot, :kummerchannel), embed: embedmsg)
  end
end
