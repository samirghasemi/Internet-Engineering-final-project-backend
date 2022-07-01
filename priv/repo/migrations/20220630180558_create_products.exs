defmodule TorobBackend.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :price, :integer
      add :user_id, references(:users, on_delete: :delete_all)
      add :shop_id, references(:shops, on_delete: :delete_all)
      add :model_id, references(:models, on_delete: :delete_all)
      timestamps()
    end
  end
end
