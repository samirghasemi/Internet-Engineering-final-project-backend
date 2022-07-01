defmodule TorobBackend.Repo.Migrations.CreateSubcategories do
  use Ecto.Migration

  def change do
    create table(:subcategories) do
      add :title, :string
      add :category, references(:categories, on_delete: :delete_all)

      timestamps()
    end
  end
end
