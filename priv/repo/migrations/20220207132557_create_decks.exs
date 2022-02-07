defmodule Rafiyol.Repo.Migrations.CreateDecks do
  use Ecto.Migration

  def change do
    create table(:decks) do
      add :name, :string
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:decks, [:name])
    create index(:decks, [:owner_id])
  end
end
