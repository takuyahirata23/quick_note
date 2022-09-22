defmodule QuickNoteWeb.UserFolderLive do
  use QuickNoteWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
        <div>
        <h1>here</h1>
        </div>
    """
  end
end
