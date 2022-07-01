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

      timestamps()
    end
    create unique_index(:models, [:name])

  end
end
