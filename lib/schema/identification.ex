defmodule Kummerbot.Schema.Identification do
  use Ecto.Schema

  schema "identification" do
    field(:user_id, :string)
    field(:nano_id, :string)
    field(:color, :integer)
  end

  def changeset(identification, params \\ %{}) do
    identification
    |> Ecto.Changeset.cast(params, [:user_id, :nano_id, :color])
    |> Ecto.Changeset.validate_required([:user_id, :nano_id, :color])
  end
end
