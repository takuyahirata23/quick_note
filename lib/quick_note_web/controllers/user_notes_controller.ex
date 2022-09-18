defmodule QuickNoteWeb.UserNotesController do
  use QuickNoteWeb, :controller

  alias QuickNote.Notes.Note
  alias QuickNote.Notes

  def new(conn, %{"id" => folder_id}) do
    changeset = Note.changeset(%Note{})
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

  def show(conn, %{"note_id" => note_id, "id" => folder_id}) do
    note = Notes.get_note_by_id(conn.assigns.current_user.id, note_id)
    render(conn, "show.html", note: note, folder_id: folder_id)
  end

  def edit(conn, %{"note_id" => note_id, "id" => folder_id}) do
    note = Notes.get_note_without_folder_by_id(conn.assigns.current_user.id, note_id)
    changeset = Note.changeset(note)

    render(conn, "edit.html", changeset: changeset, folder_id: folder_id, note_id: note_id)
  end

  def update(conn, %{"note" => attrs, "id" => folder_id, "note_id" => note_id}) do
    note = Notes.get_note_by_id(conn.assigns.current_user.id, note_id)

    case Notes.update_note(note, attrs) do
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset, folder_id: folder_id, note_id: note_id)

      {:ok, _note} ->
        redirect(conn, to: Routes.user_notes_path(conn, :show, folder_id, note.id))
    end
  end
end
