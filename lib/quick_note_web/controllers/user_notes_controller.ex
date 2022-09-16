defmodule QuickNoteWeb.UserNotesController do
  use QuickNoteWeb, :controller

  alias QuickNote.Notes.Note
  alias QuickNote.Notes

  def new(conn, %{"id" => folder_id}) do
    changeset = Notes.change_note_registration(%Note{})
    render(conn, "new.html", changeset: changeset, folder_id: folder_id)
  end

  def create(conn, %{"id" => folder_id, "note" => attrs}) do
    attrs =
      Map.merge(attrs, %{"user_id" => conn.assigns.current_user.id, "folder_id" => folder_id})

    case Notes.register_note(attrs) do
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)

      {:ok, _} ->
        redirect(conn, to: Routes.user_folders_path(conn, :show, folder_id))
    end
  end
end
