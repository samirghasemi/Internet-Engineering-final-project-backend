defmodule TorobBackend.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :message, :string

      timestamps()
    end
  end
end
