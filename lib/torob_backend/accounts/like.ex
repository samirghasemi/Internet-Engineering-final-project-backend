defmodule TorobBackend.Accounts.Like do
  use Ecto.Schema
  import Ecto.Changeset

  schema "likes" do
    field :model_id, :string
    field :user_id, :string

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs)
  end
end
