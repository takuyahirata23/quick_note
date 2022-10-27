defmodule QuickNoteWeb.HomeDashboardLive do
  use QuickNoteWeb, :live_view

  alias QuickNote.Notes

  def mount(_params, _session, socket) do
    if connected?(socket), do: Notes.subscribe_folder_activity()
    stats = Notes.get_home_dashboard_stats()

    {:ok, assign(socket, stats: stats)}
  end

  def handle_info({:folder_created, _folder}, socket) do
    {:noreply, update(socket, :folder_count, &(&1 + 1))}
  end

  def handle_info({:folder_deleted, _folder}, socket) do
    {:noreply, update(socket, :folder_count, &(&1 - 1))}
  end
end
