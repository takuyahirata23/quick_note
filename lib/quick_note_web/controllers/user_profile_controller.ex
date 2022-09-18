defmodule QuickNoteWeb.UserProfileController do
  use QuickNoteWeb, :controller

  alias QuickNote.Accounts

  def index(conn, _params) do
    render(conn, "index.html", user: conn.assigns.current_user)
  end

  def delete(conn, _params) do
    case Accounts.delete_user_account(conn.assigns.current_user) do
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong. Please try it later.")
        |> render("index.html", user: conn.assigns.current_user)

      {:ok, _user} ->
        conn
        |> put_flash(:info, "Deleted your account.")
        |> redirect(to: "/")
    end
  end
end
