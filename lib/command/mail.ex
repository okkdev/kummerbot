defmodule Kummerbot.Command.Mail do
  import Nostrum.Struct.Embed
  alias Nostrum.Api

  def send_mail({%Nostrum.Struct.Message{} = msg, %Kummerbot.Schema.Identification{} = identity}) do
    case get_attachment(msg) do
      {:ok} ->
        {msg, identity}
        |> create_embed("Anonymous")
        |> send_message()
        |> confirm(msg, identity)

      {:ok, :image, url} ->
        {msg, identity}
        |> create_embed("Anonymous")
        |> put_image(url)
        |> send_message()
        |> confirm(msg, identity)

      {:ok, :video, url} ->
        {msg, identity}
        |> create_embed("Anonymous")
        |> put_video(url)
        |> send_message()
        |> confirm(msg, identity)

      {:error, err} ->
        Api.create_message(msg.channel_id,
          embed: %Nostrum.Struct.Embed{
            description: err,
            color: identity.color
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

  defp confirm({:ok, _}, %Nostrum.Struct.Message{} = msg, identity) do
    Api.create_message(msg.channel_id,
      embed: %Nostrum.Struct.Embed{
        description: "Message delivered :love_letter:",
        color: identity.color
      }
    )
  end

  defp confirm({:error, _}, msg, identity) do
    Api.create_message(msg.channel_id,
      embed: %Nostrum.Struct.Embed{
        description: "There was an error delivering your message :pensive:",
        color: identity.color
      }
    )
  end

  defp create_embed({msg, identity}, title) do
    %Nostrum.Struct.Embed{}
    |> put_title(title)
    |> put_description(msg.content)
    |> put_color(identity.color)
    |> put_footer("@#{identity.nano_id}")
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
