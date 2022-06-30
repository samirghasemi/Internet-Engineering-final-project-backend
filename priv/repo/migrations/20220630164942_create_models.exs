defmodule TorobBackend.Repo.Migrations.CreateModels do
  use Ecto.Migration

  def change do
    create table(:models) do
      add :name, :string
      add :desc, :text
      add :avatar, :string

      timestamps()
    end
  end
end
