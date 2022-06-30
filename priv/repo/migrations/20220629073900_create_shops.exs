defmodule TorobBackend.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :name, :string
      add :avatar, :string
      add :desc, :text
      add :link, :string
      add :user_id, references(:users, on_delete: :delete_all)


      timestamps()
    end
    create unique_index(:shops, [:name])
  end
end
