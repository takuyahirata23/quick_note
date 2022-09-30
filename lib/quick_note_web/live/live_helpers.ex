defmodule QuickNoteWeb.LiveHelpers do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  def show_sidebar(js \\ %JS{}) do
    js
    |> JS.show(to: "#sidebar-overlay")
    |> JS.show(
      to: "#sidebar",
      display: "flex",
      transition: {"ease-out duration-300", "translate-x-full", "translate-x-0"}
    )
  end

  def hide_sidebar(js \\ %JS{}) do
    js
    |> JS.hide(to: "#sidebar-overlay")
    |> JS.hide(
      to: "#sidebar",
      transition: {"ease-in duration-300", "translate-x-0", "translate-x-full"}
    )
  end

  # def show_modal(js \\ %JS{}) do
  #   js
  #   |> JS.show(to: "#modal-overlay")
  #   |> JS.show(to: "#modal", display: "flex")
  # end

  # def close_modal(js \\ %JS{}) do
  #   js
  #   |> JS.hide(to: "#modal-overlay")
  #   |> JS.hide(to: "#modal")
  # end
  #
  attr :show, :boolean, default: false

  def modal(assigns) do
    ~H"""
    <div id={@id}>
      <div class="flex absolute inset-0 bg-primary/20 items-center justify-center">
        <div class="bg-white p-8 rounded-md drop-shadow-sm w-11/12">
          <%= render_slot(@inner_block) %>
          <div class="flex gap-x-4">
            <div class="flex-1">
              <.link navigate={@cancel_path} class="bg-accent rounded-md p-2 w-full">Cancel</.link>
            </div>
            <div class="flex-1">
              <button class="bg-primary text-background rounded-md p-2 w-full">Create</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
