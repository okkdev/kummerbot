defmodule KummerbotTest do
  use ExUnit.Case
  alias Kummerbot.Command.Mailer

  @test_message %Nostrum.Struct.Message{
    attachments: [],
    author: %Nostrum.Struct.User{
      bot: nil,
      discriminator: "2094",
      id: 116146991540600840,
      username: "okk"
    },
    channel_id: 583947157338456064,
    content: "Test",
    edited_timestamp: nil,
    embeds: [],
    guild_id: nil
  }

  test "Send test message" do
    {result, _} = Mailer.mail(@test_message)
    assert :ok == result
  end
end
