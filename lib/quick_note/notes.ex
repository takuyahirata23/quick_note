defmodule QuickNote.Notes do
  import Ecto.Query, warn: false

  alias QuickNote.Repo
  alias QuickNote.Notes.{Folder}

  def change_folder_registration(%Folder{} = folder, attrs \\ %{}) do
    Folder.registration_changeset(folder, attrs)
  end

  def register_folder(attrs, user) do
    %Folder{}
    |> Folder.registration_changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def get_folders(user) do
    Folder
    |> where(user_id: ^user.id)
    |> Repo.all()
  end

  def get_folders_with_note_counts(user) do
    Folder
    |> where(user_id: ^user.id)
    |> preload([:notes])
    |> Repo.all()
  end

  def get_folder_by_id(id) when is_binary(id) do
    Folder
    |> Repo.get_by!(id: id)
  end
end
