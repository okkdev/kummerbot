defmodule Kummerbot.Utils.Identity do
  require Logger
  alias Kummerbot.Repo
  alias Kummerbot.Schema.Identification

  def get_identity!(%Nostrum.Struct.User{} = user) do
    Repo.get_by!(Identification, user_id: to_string(user.id))
  end

  @doc """
  Updates nanoid.
  Returns {:ok, struct} or {:error, changeset}
  """
  def update_nanoid(%Nostrum.Struct.User{} = user) do
    get_identity!(user)
    |> Ecto.Changeset.change(nano_id: Nanoid.generate(5))
    |> Repo.update()
  end

  def check_identity(%Nostrum.Struct.User{} = user) do
    case Repo.get_by(Identification, user_id: to_string(user.id)) do
      %Identification{} = identity ->
        Logger.debug("User #{identity.nano_id} identified")
        :ok

      nil ->
        identity = create_identity!(user)
        Logger.debug("User #{identity.nano_id} created")
        :created

      _ ->
        Logger.error("Couldn't check identity")
    end
  end

  defp create_identity!(%Nostrum.Struct.User{} = user) do
    Repo.insert!(%Identification{user_id: to_string(user.id), nano_id: Nanoid.generate(5)})
  end
end
