defmodule QuickNoteWeb.NoteEditFormComponent do
  use QuickNoteWeb, :live_component

  alias QuickNote.Notes.Note
  alias QuickNote.Notes

  def update(assigns, socket) do
    changeset = Note.changeset(assigns.note)
    {:ok, assign(socket, changeset: changeset, folder_id: assigns.folder_id, note: assigns.note)}
  end

  def handle_event("edit", %{"note" => attrs}, socket) do
    case Notes.update_note(socket.assigns.note, attrs) do
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}

      {:ok, note} ->
        {:noreply,
         push_patch(socket,
           to: Routes.user_note_path(socket, :index, socket.assigns.folder_id, note.id)
         )}
    end
  end

  def render(assigns) do
    ~H"""
    <div>
    <.form let={f} for={@changeset} action="#" phx-submit="edit" phx-target={@myself}>
    <%= if @changeset.action do %>
      <div class="alert alert-danger">
      <p>Oops, something went wrong! Please check the errors below.</p>
      </div>
      <% end %>

    <div class="flex flex-col">
    <div class="flex flex-col gap-y-1">
    <%= label f, :title, class: "text-md" %>
    <%= text_input f, :title, required: true, class: "border-none bg-light rounded-md"  %>
    <%= error_tag f, :title %>
    </div>
    <div class="flex flex-col gap-y-1">
    <%= label f, :copy, class: "text-md" %>
    <%= text_input f, :copy, required: true, class: "border-none bg-light rounded-md"  %>
    <%= error_tag f, :copy %>
    </div>
    <div class="flex flex-col gap-y-1">
    <%= label f, :description, class: "text-md" %>
    <%= text_input f, :description, class: "border-none bg-light rounded-md"  %>
    <%= error_tag f, :description %>
    </div>
    <div class="flex gap-x-4 mt-8">
    <.link patch={Routes.user_note_path(@socket, :index, @folder_id, @note.id)} class="bg-accent rounded-md p-2 text-center flex-1">
    Cancel
    </.link>
    <%= submit "Update", class: "w-1/2 mx-auto bg-primary text-white py-2 rounded-md flex-1" %>
    </div>
    </div>
    </.form>
    </div>
    """
  end
end
