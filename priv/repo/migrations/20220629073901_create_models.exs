defmodule TorobBackend.Repo.Migrations.CreateModels do
  use Ecto.Migration

  def change do
    create table(:models) do
      add :name, :string
      add :desc, :text
      add :avatar, :string
      add :ram, :string
      add :storage, :string
      add :battery, :string
      add :screen_size, :string
      add :category_id, references(:categories, on_delete: :delete_all)
      add :subcategory_id, references(:subcategories, on_delete: :delete_all)
      add :brand_id, references(:brands, on_delete: :delete_all)

      timestamps()
    end
    create unique_index(:models, [:name])

  end
end
