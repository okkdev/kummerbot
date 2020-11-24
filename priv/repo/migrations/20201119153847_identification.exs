defmodule Kummerbot.Repo.Migrations.Identification do
  use Ecto.Migration

  def change do
    create table(:identification) do
      add :user_id, :string
      add :nano_id, :string
    end
  end
end
