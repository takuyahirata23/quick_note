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

  def show_modal(js \\ %JS{}) do
    js
    |> JS.show(to: "#modal-overlay")
    |> JS.show(to: "#modal", display: "flex")
  end

  def close_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal-overlay")
    |> JS.hide(to: "#modal")
  end

  def modal(assigns) do
    ~H"""
    <div class={unless @show, do: "hidden"}>
      <div id="modal" class="absolute inset-0 bg-primary/20 items-center justify-center">
        <div class="bg-white p-8 rounded-md drop-shadow-sm w-11/12">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end
end
