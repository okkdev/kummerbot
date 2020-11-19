defmodule Kummerbot.Repo do
  use Ecto.Repo,
    otp_app: :kummerbot,
    adapter: Ecto.Adapters.Postgres

  # Get DB URL from env var if available
  def init(_type, config) do
    {:ok, Keyword.put(config, :url, System.get_env("DATABASE_URL", Keyword.get(config, :url)))}
  end
end
