defmodule QuickNoteWeb.HomeDashboardLive do
  use QuickNoteWeb, :live_view

  alias QuickNote.Notes

  def mount(_params, _session, socket) do
    subscribe(socket)
    stats = Notes.get_home_dashboard_stats()

    {:ok, assign(socket, stats: stats)}
  end

  def handle_info({:folder_created, _folder}, socket) do
    {:noreply,
     update(socket, :stats, fn stats -> Map.update(stats, :folder_count, 0, &(&1 + 1)) end)}
  end

  def handle_info({:folder_deleted, _folder}, socket) do
    {:noreply,
     update(socket, :stats, fn stats -> Map.update(stats, :folder_count, 0, &(&1 - 1)) end)}
  end

  def handle_info({:note_created, _note}, socket) do
    {:noreply,
     update(socket, :stats, fn stats -> Map.update(stats, :note_count, 0, &(&1 + 1)) end)}
  end

  def handle_info({:note_deleted, _note}, socket) do
    {:noreply,
     update(socket, :stats, fn stats -> Map.update(stats, :note_count, 0, &(&1 - 1)) end)}
  end

  def subscribe(socket) do
    if connected?(socket) do
      Notes.subscribe_folder_activity()
      Notes.subscribe_note_activity()
    end
  end
end
