defmodule QuickNoteWeb.LayoutComponent do
  use QuickNoteWeb, :live_component

  def show_modal(module, attrs) do
    send_update(self(), __MODULE__, id: "layout", show: attrs.show, module: module)
  end

  def hide_modal() do
    send_update(self(), __MODULE__, id: "layout", show: false)
  end

  def update(assigns, socket) do
    IO.inspect(assigns[:show])

    case assigns[:show] do
      true ->
        {:ok, assign(socket, show: assigns[:show], id: assigns.id, module: assigns[:module])}

      _ ->
        {:ok, assign(socket, show: false)}
    end
  end

  def render(assigns) do
    ~H"""
    <div class={unless @show, do: "hidden"}>
      <%= if @show do %>
      <.modal id={@id} cancel_path={Routes.user_folder_path(@socket, :index)}>
        <.live_component module={@module} id="here"/>
      </.modal>
        <% end %>
    </div>
    """
  end
end
