defmodule TorobBackend.Accounts.Like do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "likes" do
    field :is_like, :boolean, default: true
    belongs_to :model_id , TorobBackend.Stores.Model, primary_key: true
    belongs_to :user_id , TorobBackend.Accounts.User, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:is_like])
    |> foreign_key_constraint(:model_id)
    |> foreign_key_constraint(:user_id)
  end
end
