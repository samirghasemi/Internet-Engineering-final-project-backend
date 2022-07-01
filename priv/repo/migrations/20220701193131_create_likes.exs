defmodule TorobBackend.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :is_like, :boolean, default: true, null: false
      add :user_id, references(:users, on_delete: :delete_all)
      add :model_id, references(:models, on_delete: :delete_all)
      timestamps()
    end
    create(index(:likes, [:model_id]))
    create(index(:likes, [:user_id]))
  end
end
