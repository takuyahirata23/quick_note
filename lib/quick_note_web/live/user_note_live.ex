defmodule QuickNoteWeb.UserNoteLive do
  use QuickNoteWeb, :live_view

  alias QuickNote.Notes

  def mount(%{"note_id" => note_id}, %{"user_id" => user_id}, socket) do
    note = Notes.get_note_by_id(user_id, note_id)
    {:ok, assign(socket, note: note)}
  end
end
