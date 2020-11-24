defmodule Kummerbot.Repo.Migrations.AddColor do
  use Ecto.Migration

  def change do
    alter table(:identification) do
      add :color, :integer
    end
  end
end
