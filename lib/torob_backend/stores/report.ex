defmodule TorobBackend.Stores.Report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field :message, :string
    belongs_to :user , TorobBackend.Accounts.User
    belongs_to :shop , TorobBackend.Stores.Shop
    belongs_to :product , TorobBackend.Stores.Product
    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
