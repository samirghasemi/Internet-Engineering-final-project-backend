defmodule TorobBackend.Menu.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :title, :string
    has_many :subcategories , TorobBackend.Menu.Subcategory
    has_many :models , TorobBackend.Stores.Model

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
