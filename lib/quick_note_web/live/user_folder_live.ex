defmodule QuickNoteWeb.UserFolderLive do
  use QuickNoteWeb, :live_view
  use Phoenix.Component

  alias QuickNote.Notes
  alias QuickNoteWeb.LayoutComponent

  def mount(_params, session, socket) do
    folders = get_folders(session, socket)
    {:ok, assign(socket, folders: folders, user_id: session["user_id"])}
  end

  def handle_params(_params, _url, socket) do
    IO.puts("\n\n\nRUN\n\n\n")

    case socket.assigns.live_action do
      :new ->
        LayoutComponent.show_modal(QuickNoteWeb.FolderFormComponent, %{
          show: true,
          user_id: socket.assigns.user_id
        })

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
end
