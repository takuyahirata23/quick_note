defmodule QuickNoteWeb.HomeLive do
  use QuickNoteWeb, :live_view

  def mount(_, session, socket) do
    {:ok, assign(socket, is_authenticated: check_user(session))}
  end

  def check_user(session) do
    if(session["user_id"]) do
      true
    else
      false
    end
  end
end
