defmodule QuickNoteWeb.LayoutComponent do
  use QuickNoteWeb, :live_component

  def show_modal(attrs) do
    send_update(__MODULE__, id: "layout", show: attrs.show)
  end

  def update(assigns, socket) do
    {:ok, assign(socket, show: true, id: assigns.id)}
  end

  def render(assigns) do
    ~H"""
    <div class="hidden">
      <.modal id={@id} >
        <p>hi</p>
      </.modal>
    </div>
    """
  end
end
