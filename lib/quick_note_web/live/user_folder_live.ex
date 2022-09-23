defmodule QuickNoteWeb.UserFolderLive do
  use QuickNoteWeb, :live_view

  alias QuickNote.Accounts
  alias QuickNote.Notes

  def mount(_params, session, socket) do
    IO.inspect(session)
    #    folders = get_folders(session, socket)
    {:ok, assign(socket, folders: [])}
  end

  defp get_folders(session, socket) do
    if connected?(socket) do
      Accounts.get_user_by_session_token(session["user_token"])
    else
      []
    end
  end
end
