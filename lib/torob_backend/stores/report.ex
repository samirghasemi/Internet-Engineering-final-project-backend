defmodule TorobBackend.Stores.Report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field :message, :string

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
