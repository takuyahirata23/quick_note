defmodule QuickNoteWeb.UI do
  use Phoenix.Component
  import QuickNoteWeb.LiveHelpers

  def modal(assigns) do
    assigns =
      assigns
      |> assign_new(:cancel, fn -> [] end)
      |> assign_new(:confirm, fn -> [] end)

    ~H"""
      <div id="modal" class="absolute inset-0 bg-primary/20 items-center justify-center hidden">
        <div class="bg-white p-8 rounded-md drop-shadow-sm w-11/12">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    """
  end
end

# <div class="flex justify-between gap-x-4 mt-8">
#   <%= render_slot(@cancel) %>
#   <%= render_slot(@confirm) %>
# </div>
