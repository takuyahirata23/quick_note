defmodule QuickNoteWeb.UserFoldersController do
  use QuickNoteWeb, :controller

  alias QuickNote.Notes.Folder
  alias QuickNote.Notes

  def index(conn, _params) do
    folders = Notes.get_folders(conn.assigns.current_user)
    render(conn, "index.html", folders: folders)
  end

  def new(conn, _params) do
    changeset = Notes.change_folder_registration(%Folder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"folder" => attrs}) do
    case Notes.register_folder(attrs, conn.assigns.current_user) do
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)

      {:ok, _notes} ->
        render(conn, "index.html")
    end
  end
end
