defmodule QuickNoteWeb.UserFolderDetailLive do
  use QuickNoteWeb, :live_view
  # use Phoenix.Component
  alias QuickNote.Notes

  def mount(%{"folder_id" => folder_id}, _session, socket) do
    folder = Notes.get_folder_by_id(folder_id)
    {:ok, assign(socket, folder: folder)}
  end

  def handle_params(_params, _url, socket) do
    case socket.assigns.live_action do
      :new ->
        nil

      _ ->
        nil
    end

    {:noreply, socket}
  end
end
