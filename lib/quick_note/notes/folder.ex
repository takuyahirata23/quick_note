defmodule QuickNote.Notes.Folder do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "folders" do
    field :name, :string
    field :is_pinned, :boolean, default: false

    belongs_to :user, QuickNote.Accounts.User

    has_many :notes, QuickNote.Notes.Note

    timestamps()
  end

  def registration_changeset(folder, attrs) do
    folder
    |> cast(attrs, [:name, :is_pinned])
    |> validate_required([:name])
    |> validate_length(:name, min: 2, max: 50)
  end
end
