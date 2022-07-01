defmodule TorobBackend.Stores.Model do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema

  schema "models" do
    field :avatar, TorobBackend.ModelProfile.Type
    field :desc, :string
    field :name, :string
    field :ram, :string
    field :storage, :string
    field :battery, :string
    field :screen_size, :string

    has_many :products , TorobBackend.Stores.Product
    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:name, :desc, :ram, :storage, :battery, :screen_size])
    |> cast_attachments(attrs,[:avatar])
    |> validate_required([:name, :desc, :ram, :storage, :battery, :screen_size])
    |> unique_constraint(:name)

  end
end
