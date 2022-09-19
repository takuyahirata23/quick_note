defmodule QuickNote.Repo.Migrations.CreateFoldersAndNotes do
  use Ecto.Migration

  def change do
    create table(:folders, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false, size: 50)
      add(:is_pinned, :boolean)

      add(:user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:folders, [:user_id]))

    create table(:notes, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:title, :string, null: false, size: 50)
      add(:copy, :string, null: false, size: 150)
      add(:description, :string, size: 300)
      add(:is_pinned, :boolean)

      add(:folder_id, references(:folders, type: :binary_id, on_delete: :delete_all), null: false)
      add(:user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:notes, [:user_id]))
  end
end
