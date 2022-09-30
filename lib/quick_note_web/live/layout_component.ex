defmodule QuickNoteWeb.LayoutComponent do
  use QuickNoteWeb, :live_component

  def show_modal(attrs) do
    send_update(self(), __MODULE__, id: "layout", show: attrs.show)
  end

  def hide_modal() do
    send_update(self(), __MODULE__, id: "layout", show: false)
  end

  def update(assigns, socket) do
    {:ok, assign(socket, show: assigns[:show], id: assigns.id)}
  end

  def render(assigns) do
    ~H"""
    <div class={unless @show, do: "hidden"}>
      <.modal id={@id} cancel_path={Routes.user_folder_path(@socket, :index)}>
        <p>hi</p>
      </.modal>
    </div>
    """
  end
end
