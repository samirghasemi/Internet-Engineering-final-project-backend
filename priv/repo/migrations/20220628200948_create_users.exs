defmodule TorobBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string
      add :email, :string
      add :avatar, :string
      add :is_admin, :boolean, default: false

      timestamps()
    end
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end
