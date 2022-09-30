defmodule QuickNoteWeb.LayoutComponent do
  use QuickNoteWeb, :live_component

  def show_modal(attrs) do
    send_update(self(), __MODULE__, %{id: "layout", show: attrs.show})
  end

  def update(assigns, socket) do
    IO.puts(assigns)
    {:ok, assign(socket, show: true, id: "hi")}
  end

  def render(assigns) do
    ~H"""
      <.modal id={@id} >
        <p>hi</p>
      </.modal>
    """
  end
end
