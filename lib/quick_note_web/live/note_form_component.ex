defmodule QuickNoteWeb.NoteFormComponent do
  use QuickNoteWeb, :live_component

  alias QuickNote.Notes
  alias QuickNote.Notes.Note

  def update(assigns, socket) do
    changeset = Note.changeset(%Note{})

    {:ok,
     assign(socket, changeset: changeset, folder_id: assigns.folder_id, user_id: assigns.user_id)}
  end

  def handle_event("create", %{"note" => attrs}, socket) do
    attrs =
      Map.merge(attrs, %{
        "user_id" => socket.assigns.user_id,
        "folder_id" => socket.assigns.folder_id
      })

    case Notes.register_note(attrs) do
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}

      {:ok, _note} ->
        {:noreply,
         push_patch(socket,
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
      <.form :let={f} for={@changeset} action="#" phx-submit="create" phx-target={@myself}>
        <%= if @changeset.action do %>
          <div class="alert alert-danger">
          <p>Oops, something went wrong! Please check the errors below.</p>
          </div>
          <% end %>

        <div class="flex flex-col gap-y-4">
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
          <%= textarea f, :description, class: "border-none bg-light rounded-md", rows: 4 %>
          <%= error_tag f, :description %>
            </div>
            <div class="flex gap-x-4 items-center-8 mt-8">
            <div class="flex-1">
            <.link patch={Routes.user_folder_detail_path(@socket, :index, @folder_id)} class="bg-accent rounded-md p-2 w-full block text-center">
            Cancel
            </.link>
            </div>
            <div class="flex-1">
            <%= submit "Save", class: "bg-primary text-background rounded-md p-2 w-full" %>
            </div>
          </div>
        </div>
      </.form>
    </div>
    """
  end
end
