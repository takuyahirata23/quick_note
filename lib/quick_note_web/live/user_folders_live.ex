defmodule QuickNoteWeb.UserFoldersLive do
  use QuickNoteWeb, :live_view
  use Phoenix.Component

  alias QuickNote.Notes
  alias QuickNoteWeb.LayoutComponent

  def mount(_params, session, socket) do
    {:ok, assign(socket, user_id: session["user_id"])}
  end

  def handle_params(_params, _url, socket) do
    case socket.assigns.live_action do
      :new ->
        LayoutComponent.show_modal(QuickNoteWeb.FolderFormComponent, %{
          show: true,
          user_id: socket.assigns.user_id
        })

      _ ->
        LayoutComponent.hide_modal()
    end

    folders = Notes.get_folders_with_note_counts_by_user_id(socket.assigns.user_id)

    {:noreply, assign(socket, folders: folders)}
  end
end
