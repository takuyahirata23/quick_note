defmodule QuickNoteWeb.UserFolderLive do
  use QuickNoteWeb, :live_view
  use Phoenix.Component

  #  alias QuickNote.Accounts
  alias QuickNote.Notes.Folder
  #  alias QuickNote.Notes
  alias QuickNoteWeb.LayoutComponent

  def mount(_params, session, socket) do
    changeset = Folder.changeset(%Folder{})
    #    folders = get_folders(session, socket)
    {:ok, assign(socket, folders: [], changeset: changeset)}
  end

  def handle_params(params, url, socket) do
    LayoutComponent.show_modal(%{show: true})
    {:noreply, socket}
  end

  # defp get_folders(session, socket) do
  #   if connected?(socket) do
  #     Accounts.get_user_by_session_token(session["user_token"])
  #   else
  #     []
  #   end
  # end
  #

  def handle_event("create", params, socket) do
    IO.inspect(params)

    push_patch(socket, to: "/users/folders")
    changeset = Folder.changeset(%Folder{})
    #    folders = get_folders(session, socket)
    {:noreply, assign(socket, folders: [], changeset: changeset)}
  end
end
