defmodule QuickNote.Repo.Migrations.AddColumnsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:is_admin, :boolean)
      add(:name, :string, null: false, size: 30)
    end
  end
end
