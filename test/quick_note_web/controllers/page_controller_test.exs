defmodule QuickNoteWeb.PageControllerTest do
  use QuickNoteWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Quick Note 👋"
  end
end
