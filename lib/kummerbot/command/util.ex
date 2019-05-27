defmodule Kummerbot.Command.Util do
  alias Nostrum.Api

  import Nostrum.Struct.Embed

  require Logger

  def mail(msg) do
    Api.create_message(msg.channel_id, "Thank you :slight_smile:")

    embedmsg =
      %Nostrum.Struct.Embed{}
      |> put_title("Anonym")
      |> put_description(msg.content)
      |> put_color(Enum.random(1..16777215))

    Api.create_message(Application.get_env(:kummerbot, :kummerchannel), embed: embedmsg)
  end
end
