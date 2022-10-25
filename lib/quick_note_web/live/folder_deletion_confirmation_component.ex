defmodule QuickNoteWeb.FolderDeletionConfirmationComponent do
  use QuickNoteWeb, :live_component

  alias QuickNote.Notes
  alias QuickNote.Notes.Folder
  import Ecto.Changeset

  def update(%{folder_id: folder_id}, socket) do
    folder = Notes.get_folder_by_id(folder_id)
    changeset = Folder.delete_confirmation_changeset(%Folder{}, "")
    {:ok, assign(socket, folder: folder, changeset: changeset)}
  end

  def handle_event("delete", %{"folder" => attrs}, socket) do
    changeset = Folder.delete_confirmation_changeset(%Folder{}, socket.assigns.folder.name, attrs)

    case changeset.valid? do
      false ->
        {:error, changeset} = apply_action(changeset, :delete)
        {:noreply, assign(socket, changeset: changeset)}

      true ->
        case Notes.delete_folder(socket.assigns.folder) do
          {:error, _} ->
            socket = put_flash(socket, :error, "No")
            {:noreply, socket}

          {:ok, _} ->
            {:noreply, push_navigate(socket, to: "/users/folders")}
        end
    end
  end

  def render(assigns) do
    ~H"""
    <div>
    <p class="font-semibold">Are you sure you want to delete this note?</p>
    <p class="font-semibold">Type folder name: <strong class="py-1 px-2 bg-accent/70 rounded-md"><%= @folder.name %></strong> below</p>
    <.form :let={f} for={@changeset} phx-target={@myself} action="#" phx-submit="delete" class="gap-x-2 mt-8">
    <div class="flex flex-col gap-y-1">
    <%= label f, :title, class: "text-md" %>
    <%= text_input f, :name, required: true, class: "border-none bg-light rounded-md"  %>
    <%= error_tag f, :name %>
    </div>
    <div class="flex mt-8 gap-x-4">
    <.link patch={Routes.user_folder_detail_path(@socket, :index, @folder.id)} class="bg-accent rounded-md p-2 text-center flex-1">
    Cancel
    </.link>
    <button type="submit"  class="flex-1 bg-secondary text-background rounded-lg">
    Delete
    </button>
    </div>
    </.form>
    </div>
    """
  end
end
