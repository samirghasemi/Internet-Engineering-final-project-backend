defmodule TorobBackend.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :user_id, :string
      add :model_id, :string

      timestamps()
    end
  end
end
