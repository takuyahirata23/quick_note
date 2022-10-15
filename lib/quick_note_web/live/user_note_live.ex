defmodule QuickNoteWeb.UserNoteLive do
  use QuickNoteWeb, :live_view

  alias QuickNote.Notes
  alias QuickNoteWeb.LayoutComponent

  def mount(%{"note_id" => note_id, "folder_id" => folder_id}, %{"user_id" => user_id}, socket) do
    {:ok, assign(socket, folder_id: folder_id, note_id: note_id, user_id: user_id)}
  end

  def handle_params(_params, _url, socket) do
    note = Notes.get_note_by_id(socket.assigns.user_id, socket.assigns.note_id)

    case socket.assigns.live_action do
      :edit ->
        LayoutComponent.show_modal(%{
          module: QuickNoteWeb.NoteEditFormComponent,
          show: true,
          note: note,
          folder_id: socket.assigns.folder_id
        })

      _ ->
        LayoutComponent.hide_modal()
    end

    {:noreply, assign(socket, note: note)}
  end

  def handle_event("delete", _params, socket) do
    case Notes.delete_note(socket.assigns.note) do
      {:error, _} ->
        socket =
          socket
          |> put_flash(:error, "Something went wrong. Please try it later.")

        {:noreply, socket}

      {:ok, _note} ->
        {:noreply,
         push_navigate(socket,
           to: Routes.user_folder_detail_path(socket, :index, socket.assigns.folder_id)
         )}
    end
  end
end
