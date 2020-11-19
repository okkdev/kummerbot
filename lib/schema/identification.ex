defmodule Kummerbot.Schema.Identification do
  use Ecto.Schema

  schema "identification" do
    field(:user_id, :string)
    field(:nano_id, :string)
  end

  def changeset(identification, params \\ %{}) do
    identification
    |> Ecto.Changeset.cast(params, [:user_id, :nano_id])
    |> Ecto.Changeset.validate_required([:user_id, :nano_id])
  end
end
