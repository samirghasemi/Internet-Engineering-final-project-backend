defmodule TorobBackend.Stores.Shop do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema

  schema "shops" do
    field :avatar, TorobBackend.ShopProfile.Type
    field :desc, :string
    field :link, :string
    field :name, :string
    belongs_to :user , TorobBackend.Accounts.User
    has_many :products , TorobBackend.Stores.Product
    has_many :reports, TorobBackend.Stores.Report

    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:name, :desc, :link])
    |> cast_attachments(attrs,[:avatar])
    |> validate_required([:name, :desc, :link])
    |> unique_constraint(:name)


  end
end
