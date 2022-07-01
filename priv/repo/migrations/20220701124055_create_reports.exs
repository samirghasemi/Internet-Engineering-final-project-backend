defmodule TorobBackend.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :message, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :product_id, references(:products, on_delete: :delete_all)
      add :shop_id, references(:shops, on_delete: :delete_all)

      timestamps()
    end
  end
end
