defmodule TorobBackend.Accounts.Like do
  use Ecto.Schema
  import Ecto.Changeset

  schema "likes" do
    field :is_like, :boolean, default: true
    belongs_to :model , TorobBackend.Stores.Model
    belongs_to :user , TorobBackend.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:is_like])

  end
end
