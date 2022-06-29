defmodule TorobBackend.Stores.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :avatar, TorobBackend.ShopProfile.Type
    field :desc, :string
    field :link, :string
    field :name, :string
    belongs_to :user , TorobBackend.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:name, :avatar, :desc, :link, :avatar])
    |> validate_required([:name, :avatar, :desc, :link, :avatar])
  end
end
