defmodule Kummerbot.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api
  alias Kummerbot.Consumer.MessageCreate

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    MessageCreate.handle(msg)
  end

  def handle_event({:READY, _data, _ws_state}) do
    :ok = Api.update_status(:online, "your concerns", 2)
  end

  def handle_event(_event) do
    :noop
  end
end
