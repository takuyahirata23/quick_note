defmodule QuickNoteWeb.FolderEditFormComponent do
  use QuickNoteWeb, :live_component

  alias QuickNote.Notes
  alias QuickNote.Notes.Folder

  def update(%{folder_id: folder_id}, socket) do
    folder = Notes.get_folder_by_id(folder_id)
    changeset = Folder.changeset(folder)
    {:ok, assign(socket, changeset: changeset, folder: folder)}
  end

  def handle_event("update", %{"folder" => attrs}, socket) do
    case Notes.update_folder(socket.assigns.folder, attrs) do
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}

      {:ok, _} ->
        {:noreply,
         push_patch(socket,
           to:
             Routes.live_path(
               socket,
               QuickNoteWeb.UserFolderDetailLive,
               socket.assigns.folder.id
             )
         )}
    end
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form :let={f} for={@changeset}  phx-submit="update" action="#" phx-target={@myself}>
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
            <div class="flex gap-x-4 items-center-8 mt-8">
            <div class="flex-1">
            <.link patch={Routes.live_path(@socket, QuickNoteWeb.UserFolderDetailLive, @folder.id)} class="bg-accent rounded-md p-2 w-full block text-center">
            Cancel
            </.link>
            </div>
            <div class="flex-1">
            <%= submit "Save", class: "bg-primary text-background rounded-md p-2 w-full" %>
          </div>
        </div>
      </.form>
    </div>
    """
  end
end
