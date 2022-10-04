defmodule QuickNoteWeb.FolderFormComponent do
  use QuickNoteWeb, :live_component

  alias QuickNote.Notes.Folder
  alias QuickNote.Accounts
  alias QuickNote.Notes

  def update(assigns, socket) do
    changeset = Folder.changeset(%Folder{})
    user = Accounts.get_user!(assigns.user_id)
    {:ok, assign(socket, changeset: changeset, user: user)}
  end

  def handle_event("create", %{"folder" => attrs}, socket) do
    case Notes.register_folder(attrs, socket.assigns.user) do
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, changeset: changeset}

      {:ok, _notes} ->
        {:noreply, push_patch(socket, to: "/users/folders")}
    end

    {:noreply, push_patch(socket, to: "/users/folders")}
  end

  def render(assigns) do
    ~H"""
    <div>
    <.form :let={f} for={@changeset}  phx-submit="create" action="#" phx-target={@myself}>
      <%= if @changeset.action do %>
        <div class="alert alert-danger">
          <p>Oops, something went wrong! Please check the errors below.</p>
        </div>
      <% end %>

      <div class="flex flex-col">
        <div class="flex flex-col gap-y-1">
          <%= label f, :name, class: "text-md" %>
          <%= text_input f, :name, required: true, class: "border-none bg-light rounded-md"  %>
          <%= error_tag f, :name %>
        </div>
      </div>
    </.form>
    </div>
    """
  end
end
