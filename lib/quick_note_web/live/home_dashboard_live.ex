defmodule QuickNoteWeb.HomeDashboardLive do
  use QuickNoteWeb, :live_view

  alias QuickNote.Notes

  def mount(_params, _session, socket) do
    if connected?(socket), do: Notes.subscribe_folder_activity()
    folder_count = Notes.get_folder_count()
    {:ok, assign(socket, folder_count: folder_count)}
  end

  def handle_info({:folder_created, _folder}, socket) do
    {:noreply, update(socket, :folder_count, &(&1 + 1))}
  end

  def handle_info({:folder_deleted, _folder}, socket) do
    {:noreply, update(socket, :folder_count, &(&1 - 1))}
  end
end
