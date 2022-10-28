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
        socket = put_flash(socket, :error, "There was a problem updating folder")
        {:noreply, assign(socket, changeset: changeset)}

      {:ok, _} ->
        socket = put_flash(socket, :info, "Updated folder")

        {:noreply,
         push_patch(socket,
           to:
             Routes.user_folder_detail_path(
               socket,
               :index,
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

            <div class="flex gap-x-2 items-center mt-2">
            <%= label f, :is_pinned, "Pin" ,class: "text-sm" %>
          <%= checkbox f, :is_pinned %>
            </div>
            </div>
            <div class="flex gap-x-4 items-center-8 mt-8">
            <div class="flex-1">
            <.link patch={Routes.user_folder_detail_path(@socket, :index, @folder.id)} class="bg-accent rounded-md p-2 w-full block text-center">
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
