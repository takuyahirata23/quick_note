defmodule QuickNoteWeb.UserFolderLive do
  use QuickNoteWeb, :live_view
  import QuickNoteWeb.UI

  alias QuickNote.Accounts
  alias QuickNote.Notes.Folder
  alias QuickNote.Notes

  use Phoenix.Component
  import QuickNoteWeb.LiveHelpers

  def mount(_params, session, socket) do
    IO.inspect(session)
    changeset = Folder.changeset(%Folder{})
    #    folders = get_folders(session, socket)
    {:ok, assign(socket, folders: [], changeset: changeset)}
  end

  defp get_folders(session, socket) do
    if connected?(socket) do
      Accounts.get_user_by_session_token(session["user_token"])
    else
      []
    end
  end

  def handle_event("create", params, socket) do
    IO.inspect(params)

    push_patch(socket, to: "/users/folders")
    changeset = Folder.changeset(%Folder{})
    #    folders = get_folders(session, socket)
    {:noreply, assign(socket, folders: [], changeset: changeset)}
  end
end
