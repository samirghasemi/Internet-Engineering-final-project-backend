defmodule TorobBackend.Repo.Migrations.AddPhone do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name , :string
    end
  end
end
