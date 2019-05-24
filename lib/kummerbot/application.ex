defmodule Kummerbot.Application do
  @moduledoc false

  use Application

  alias Kummerbot.Consumer

  def start(_type, _args) do
    children =
      for i <- 1..System.schedulers_online(), do: Supervisor.child_spec({Consumer, []}, id: i)

    opts = [strategy: :one_for_one, name: Kummerbot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
