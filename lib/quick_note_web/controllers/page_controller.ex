defmodule QuickNoteWeb.PageController do
  use QuickNoteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
