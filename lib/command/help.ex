defmodule Kummerbot.Command.Help do
  import Nostrum.Struct.Embed
  alias Nostrum.Api

  def send_help(msg) do
    embed =
      %Nostrum.Struct.Embed{}
      |> put_title("Help")
      |> put_author("Kummerbot", "https://github.com/okkdev/kummerbot", nil)
      |> put_field("message without prefix", "Send anonymous messages to the server")
      |> put_field(".help", "Get help")
      |> put_field(".id", "Get your current ID")
      |> put_field(".resetid", "Get a new ID")
      |> put_color(Application.get_env(:kummerbot, :embed_color))
      |> put_footer("Kummerbot made by okk#2094 ❤️")

    Api.create_message(msg.channel_id, embed: embed)
  end
end
