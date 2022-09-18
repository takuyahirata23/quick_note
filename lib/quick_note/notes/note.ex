defmodule QuickNote.Notes.Note do
  use Ecto.Schema

  import Ecto.Changeset

  alias QuickNote.Notes.Folder
  alias QuickNote.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "notes" do
    field :title, :string
    field :copy, :string
    field :description, :string
    field :is_pinned, :boolean, default: false

    belongs_to :user, User
    belongs_to :folder, Folder

    timestamps()
  end

  def changeset(notes, attrs \\ %{}) do
    notes
    |> cast(attrs, [:title, :copy, :description, :is_pinned, :folder_id, :user_id])
    |> validate_required([:title, :copy, :folder_id, :user_id])
    |> validate_length(:title, min: 2, max: 50)
    |> validate_length(:copy, min: 2, max: 150)
  end
end
