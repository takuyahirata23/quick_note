defmodule QuickNoteWeb.UserFolderLive do
  use QuickNoteWeb, :live_view
  use Phoenix.Component

  alias QuickNote.Notes.Folder
  alias QuickNote.Notes
  alias QuickNoteWeb.LayoutComponent

  def mount(_params, session, socket) do
    folders = get_folders(session, socket)
    {:ok, assign(socket, folders: folders)}
  end

  def handle_params(_params, _url, socket) do
    case socket.assigns.live_action do
      :new ->
        LayoutComponent.show_modal(QuickNoteWeb.FolderFormComponent, %{show: true})

      _ ->
        LayoutComponent.hide_modal()
    end

    {:noreply, socket}
  end

  defp get_folders(session, socket) do
    if connected?(socket) do
      Notes.get_folders_with_note_counts_by_user_id(session["user_id"])
    else
      []
    end
  end

  def handle_event("create", _params, socket) do
    push_patch(socket, to: "/users/folders")
    changeset = Folder.changeset(%Folder{})
    {:noreply, assign(socket, folders: [], changeset: changeset)}
  end
end
