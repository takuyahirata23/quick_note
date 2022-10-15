defmodule QuickNoteWeb.UserFolderDetailLive do
  use QuickNoteWeb, :live_view
  # use Phoenix.Component
  alias QuickNote.Notes
  alias QuickNoteWeb.LayoutComponent

  def mount(%{"folder_id" => folder_id}, session, socket) do
    {:ok, assign(socket, folder_id: folder_id, user_id: session["user_id"])}
  end

  def handle_params(_params, _url, socket) do
    LayoutComponent.hide_modal()

    case socket.assigns.live_action do
      :new ->
        LayoutComponent.show_modal(%{
          module: QuickNoteWeb.NoteFormComponent,
          show: true,
          folder_id: socket.assigns.folder_id,
          user_id: socket.assigns.user_id
        })

      :edit ->
        LayoutComponent.show_modal(%{
          module: QuickNoteWeb.FolderEditFormComponent,
          show: true,
          folder_id: socket.assigns.folder_id
        })

      _ ->
        LayoutComponent.hide_modal()
    end

    folder = Notes.get_folder_with_notes_by_id(socket.assigns.folder_id)
    {:noreply, assign(socket, folder: folder)}
  end

  def handle_event("delete", _params, socket) do
    folder = Notes.get_folder_by_id(socket.assigns.folder_id)

    case Notes.delete_folder(folder) do
      {:error, _} ->
        socket = put_flash(socket, :error, "No")
        {:noreply, socket}

      {:ok, _} ->
        {:noreply, push_navigate(socket, to: "/users/folders")}
    end
  end
end
