defmodule Kummerbot.Command.Mail do
  import Nostrum.Struct.Embed
  alias Nostrum.Api
  alias Kummerbot.Utils.Identity

  def send_mail(msg) do
    case get_attachment(msg) do
      {:ok} ->
        msg
        |> create_embed("Anonymous")
        |> send_message()
        |> confirm(msg.channel_id)

      {:ok, :image, url} ->
        msg
        |> create_embed("Anonymous")
        |> put_image(url)
        |> send_message()
        |> confirm(msg.channel_id)

      {:ok, :video, url} ->
        msg
        |> create_embed("Anonymous")
        |> put_video(url)
        |> send_message()
        |> confirm(msg.channel_id)

      {:error, err} ->
        Api.create_message(msg.channel_id,
          embed: %Nostrum.Struct.Embed{
            description: err
          }
        )
    end
  end

  defp send_message(embed) do
    send_message(embed, :kummer)
  end

  defp send_message(embed, :kummer) do
    Api.create_message(Application.get_env(:kummerbot, :kummer_channel), embed: embed)
  end

  defp confirm({:ok, _}, channel_id) do
    Api.create_message(channel_id,
      embed: %Nostrum.Struct.Embed{
        description: "Message delivered :love_letter:",
        color: Application.get_env(:kummerbot, :embed_color)
      }
    )
  end

  defp confirm({:error, _}, channel_id) do
    Api.create_message(channel_id,
      embed: %Nostrum.Struct.Embed{
        description: "There was an error delivering your message :pensive:",
        color: Application.get_env(:kummerbot, :embed_color)
      }
    )
  end

  defp create_embed(%Nostrum.Struct.Message{} = msg, title) do
    %Nostrum.Struct.Embed{}
    |> put_title(title)
    |> put_description(msg.content)
    |> put_color(Enum.random(1..16_777_215))
    |> put_footer("@#{Identity.get_identity!(msg.author).nano_id}")
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
