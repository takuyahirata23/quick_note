defmodule QuickNoteWeb.UserFoldersController do
  use QuickNoteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
