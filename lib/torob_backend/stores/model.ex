defmodule TorobBackend.Stores.Model do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema

  schema "models" do
    field :avatar, TorobBackend.ModelProfile.Type
    field :desc, :string
    field :name, :string
    has_many :products , TorobBackend.Stores.Product
    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:name, :desc])
    |> cast_attachments(attrs,[:avatar])
    |> validate_required([:name, :desc])
    |> unique_constraint(:name)

  end
end
