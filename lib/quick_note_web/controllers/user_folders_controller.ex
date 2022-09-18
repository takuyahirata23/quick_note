defmodule QuickNoteWeb.UserFoldersController do
  use QuickNoteWeb, :controller

  alias QuickNote.Notes.Folder
  alias QuickNote.Notes

  def index(conn, _params) do
    folders = Notes.get_folders_with_note_counts(conn.assigns.current_user)
    render(conn, "index.html", folders: folders)
  end

  def new(conn, _params) do
    changeset = Folder.changeset(%Folder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"folder" => attrs}) do
    case Notes.register_folder(attrs, conn.assigns.current_user) do
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)

      {:ok, _notes} ->
        redirect(conn, to: Routes.user_folders_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    folder = Notes.get_folder_by_id(id)
    render(conn, "show.html", folder: folder)
  end

  def edit(conn, %{"id" => id}) do
    folder = Notes.get_folder_by_id(id)
    changeset = Folder.changeset(folder)
    render(conn, "edit.html", folder: folder, changeset: changeset)
  end

  def update(conn, %{"id" => id, "folder" => attrs}) do
    folder = Notes.get_folder_by_id(id)

    case Notes.update_folder(folder, attrs) do
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", folder: folder, changeset: changeset)

      {:ok, _folder} ->
        redirect(conn, to: Routes.user_folders_path(conn, :show, id))
    end
  end
end
