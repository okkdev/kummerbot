defmodule Kummerbot.Command.Mailer do
  alias Nostrum.Api

  import Nostrum.Struct.Embed

  def mail(msg) do
    case get_attachment(msg) do
      {:ok} ->
        msg.content
        |> create_embed("Anonymous")
        |> sendmsg()
        |> confirm(msg.channel_id)

      {:ok, :image, url} ->
        msg.content
        |> create_embed("Anonymous")
        |> put_image(url)
        |> sendmsg()
        |> confirm(msg.channel_id)

      {:ok, :video, url} ->
        msg.content
        |> create_embed("Anonymous")
        |> put_video(url)
        |> sendmsg()
        |> confirm(msg.channel_id)

      {:error, err} ->
        Api.create_message(msg.channel_id, err)
    end
  end

  defp sendmsg(embed) do
    sendmsg(embed, :kummer)
  end

  defp sendmsg(embed, :kummer) do
    Api.create_message(Application.get_env(:kummerbot, :kummer_channel), embed: embed)
  end

  defp confirm({:ok, _}, channel_id) do
    Api.create_message(channel_id, "Message delivered :love_letter:")
  end

  defp confirm({:error, _}, channel_id) do
    Api.create_message(channel_id, "There was an error delivering your message :pensive:")
  end

  defp create_embed(content, title) do
    %Nostrum.Struct.Embed{}
    |> put_title(title)
    |> put_description(content)
    |> put_color(Enum.random(1..16_777_215))
    |> put_footer("@" <> Nanoid.generate(5))
  end

  defp get_attachment(%{attachments: []}) do
    {:ok}
  end

  defp get_attachment(%{attachments: [%{url: url} | _]} = msg) do
    [filetype | _] =
      String.split(url, ".")
      |> Enum.reverse()

    get_attachment(msg, filetype)
  end

  defp get_attachment(%{attachments: [%{url: url} | _]}, filetype)
       when filetype in ["mp4"] do
    {:ok, :video, url}
  end

  defp get_attachment(%{attachments: [%{url: url} | _]}, filetype)
       when filetype in ["jpeg", "jpg", "png", "gif"] do
    {:ok, :image, url}
  end

  defp get_attachment(_msg, _filetype) do
    {:error, "Filetype not supported :triumph:"}
  end
end
