defmodule TorobBackend.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes, primary_key: false) do
      add :is_like, :boolean, default: true, null: false
      add :user_id, references(:users, on_delete: :delete_all, primary_key: true)
      add :model_id, references(:models, on_delete: :delete_all, primary_key: true)
      timestamps()
    end
    create(index(:likes, [:model_id]))
    create(index(:likes, [:user_id]))
  end
end
