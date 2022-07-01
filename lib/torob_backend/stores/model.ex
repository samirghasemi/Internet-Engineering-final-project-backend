defmodule TorobBackend.Stores.Model do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema

  schema "models" do
    field :avatar, TorobBackend.ModelProfile.Type
    field :desc, :string
    field :name, :string
    field :image, :string
    field :ram, :string
    field :storage, :string
    field :battery, :string
    field :screen_size, :string

    belongs_to :category , TorobBackend.Menu.Category
    belongs_to :subcategory , TorobBackend.Menu.Subcategory
    belongs_to :brand , TorobBackend.Menu.Brand
    has_many :products , TorobBackend.Stores.Product
    has_many :likes, TorobBackend.Accounts.Like

    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:name, :desc, :ram, :storage, :battery, :screen_size, :image])
    |> cast_attachments(attrs,[:avatar])
    |> validate_required([:name, :desc, :ram, :storage, :battery, :screen_size])
    |> unique_constraint(:name)

  end
end
