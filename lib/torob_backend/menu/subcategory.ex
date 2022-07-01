defmodule TorobBackend.Menu.Subcategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subcategories" do
    field :title, :string
    belongs_to :category , TorobBackend.Menu.Category
    timestamps()
  end

  @doc false
  def changeset(subcategory, attrs) do
    subcategory
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
