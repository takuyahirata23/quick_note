defmodule QuickNoteWeb.FolderFormComponent do
  use QuickNoteWeb, :live_component

  alias QuickNote.Notes.Folder

  def update(_assigns, socket) do
    changeset = Folder.changeset(%Folder{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("create", params, socket) do
    IO.puts("\n\n\n")
    IO.inspect(params)
    IO.puts("\n\n\n")
    {:noreply, socket}
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

# <%= submit "Create", class: "w-1/2 mx-auto bg-primary text-white py-2 rounded-md mt-4" %>
