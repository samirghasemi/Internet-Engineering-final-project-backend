defmodule TorobBackend.Menu.Brand do
  use Ecto.Schema
  import Ecto.Changeset

  schema "brands" do
    field :title, :string
    belongs_to :subcategory , TorobBackend.Menu.Category

    timestamps()
  end

  @doc false
  def changeset(brand, attrs) do
    brand
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
