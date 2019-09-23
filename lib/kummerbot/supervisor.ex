defmodule Kummerbot.Supervisor do
  def start_link do
    children = [Kummerbot.Consumer]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
