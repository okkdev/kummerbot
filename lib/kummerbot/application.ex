defmodule Kummerbot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    Kummerbot.Supervisor.start_link
  end
end
