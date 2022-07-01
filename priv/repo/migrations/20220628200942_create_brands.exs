defmodule TorobBackend.Repo.Migrations.CreateBrands do
  use Ecto.Migration

  def change do
    create table(:brands) do
      add :title, :string
      add :subcategory_id, references(:subcategories, on_delete: :delete_all)

      timestamps()
    end
  end
end
