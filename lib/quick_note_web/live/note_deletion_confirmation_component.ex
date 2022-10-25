defmodule QuickNoteWeb.NoteDeletionConfirmationComponent do
  use QuickNoteWeb, :live_component

  alias QuickNote.Notes

  def update(%{folder_id: folder_id, note: note}, socket) do
    {:ok, assign(socket, folder_id: folder_id, note: note)}
  end

  def handle_event("delete", _params, socket) do
    case Notes.delete_note(socket.assigns.note) do
      {:error, _} ->
        socket =
          socket
          |> put_flash(:error, "Something went wrong. Please try it later.")

        {:noreply,
         push_patch(socket,
           to:
             Routes.user_folder_detail_path(
               socket,
               :index,
               socket.assigns.folder_id
             )
         )}

      {:ok, _note} ->
        {:noreply,
         push_navigate(socket,
           to:
             Routes.user_folder_detail_path(
               socket,
               :index,
               socket.assigns.folder_id
             )
         )}
    end
  end

  def render(assigns) do
    ~H"""
    <div>
    <p class="font-semibold">Are you sure you want to delete this note?</p>
    <div class="flex gap-x-2 mt-8">
    <.link patch={Routes.user_note_path(@socket, :index, @folder_id, @note.id)} class="bg-accent rounded-md p-2 text-center flex-1">
    Cancel
    </.link>
    <button phx-click="delete" phx-target={@myself} class="flex-1 bg-secondary text-background rounded-lg">
    Delete
    </button>
    </div>
    </div>
    """
  end
end
