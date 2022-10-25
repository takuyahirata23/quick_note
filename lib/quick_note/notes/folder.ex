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

  def changeset(folder, attrs \\ %{}) do
    folder
    |> cast(attrs, [:name, :is_pinned])
    |> validate_required([:name])
    |> validate_length(:name, min: 2, max: 50)
  end

  def delete_confirmation_changeset(folder, folder_name, attrs \\ %{}) do
    folder
    |> cast(attrs, [:name])
    |> check_folder_names_match(folder_name)
  end

  def check_folder_names_match(changeset, confirmation_name) do
    case get_change(changeset, :name) == confirmation_name do
      false -> changeset |> add_error(:name, "Folder name is not correct")
      true -> changeset
    end
  end
end
