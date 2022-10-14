defmodule QuickNoteWeb.LayoutComponent do
  use QuickNoteWeb, :live_component

  def show_modal(attrs) do
    send_update(self(), __MODULE__, id: "layout", show: attrs.show, content_attrs: attrs)
  end

  def hide_modal() do
    send_update(self(), __MODULE__, id: "layout", show: false)
  end

  def update(assigns, socket) do
    case assigns[:show] do
      true ->
        {:ok,
         assign(socket,
           show: assigns[:show],
           id: assigns.id,
           content_attrs: assigns.content_attrs
         )}

      _ ->
        {:ok, assign(socket, show: false)}
    end
  end

  def render(assigns) do
    ~H"""
    <div class={unless @show, do: "hidden"}>
      <%= if @show do %>
        <.modal id={@id}>
          <.live_component id="here" {@content_attrs}/>
        </.modal>
        <% end %>
    </div>
    """
  end
end
