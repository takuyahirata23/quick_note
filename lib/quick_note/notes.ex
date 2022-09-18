defmodule QuickNote.Notes do
  import Ecto.Query, warn: false

  alias QuickNote.Repo
  alias QuickNote.Notes.{Folder, Note}

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
    query =
      from f in Folder,
        where: [user_id: ^user.id],
        left_join: n in assoc(f, :notes),
        group_by: f.id,
        select: %{folder: f, note_count: count(n.id)}

    Repo.all(query)
  end

  def get_folder_by_id(id) when is_binary(id) do
    query =
      from f in Folder,
        where: [id: ^id],
        preload: [:notes]

    Repo.one(query)
  end

  def update_folder(folder, attrs) do
    folder
    |> Folder.folder_changeset(attrs)
    |> Repo.update()
  end

  def change_note_registration(%Note{} = note, attrs \\ %{}) do
    Note.registration_changeset(note, attrs)
  end

  def register_note(attrs) do
    %Note{}
    |> Note.registration_changeset(attrs)
    |> Repo.insert()
  end

  def get_note_by_id(user_id, id) do
    Note
    |> where(user_id: ^user_id)
    |> where(id: ^id)
    |> Repo.one()
  end

  def get_note_without_folder_by_id(user_id, id) do
    Note
    |> where(user_id: ^user_id)
    |> where(id: ^id)
    |> select([:id, :title, :copy, :description])
    |> Repo.one()
  end

  def update_note(note, attrs) do
    note
    |> Note.note_changeset(attrs)
    |> Repo.update()
  end
end
