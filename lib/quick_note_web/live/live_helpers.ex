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

  attr :id, :string, required: true

  def modal(assigns) do
    ~H"""
    <div id={@id}>
      <div class="flex absolute inset-0 bg-primary/20 items-center justify-center z-50">
        <div class="bg-white p-8 rounded-md drop-shadow-sm w-11/12">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  def patch_back_button(assigns) do
    ~H"""
    <.link patch={@patch} class="flex gap-x-2 items-center">
      <%= Heroicons.icon("arrow-left", type: "outline", class: "w-6") %>
      <span>Back</span>
    </.link>
    """
  end

  def hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 300,
      transition:
        {"transition ease-in duration-300", "transform opacity-100 scale-100",
         "transform opacity-0"}
    )
  end

  def flash(%{kind: :info} = assigns) do
    ~H"""
    <%= if live_flash(@flash, @kind) do %>
      <div 
      id="flash"
      phx-click={JS.push("lv:clear-flash") |> hide("#flash") |> JS.remove_class("fade-in-scale", to: "#flash")}
      class="bg-accent flex gap-x-4 items-center rounded-lg px-4 py-2 absolute bottom-8 left-0 right-0 z-100 fade-in-scale">
      <div class="grow text-dark">
      <%= live_flash(@flash, @kind)%>
      </div>
      <button type="button" class="self-end">
    <%= Heroicons.icon("x-mark", type: "outline", class: "w-6 text-dark") %>
    </button>
    </div>
    <% end %>
    """
  end

  def flash(%{kind: :error} = assigns) do
    ~H"""
    <%= if live_flash(@flash, @kind) do %>
      <div 
      id="flash"
      phx-click={JS.push("lv:clear-flash") |> hide("#flash") |> JS.remove_class("fade-in-scale", to: "#flash")}
      class="bg-secondary flex gap-x-4 items-center rounded-lg px-4 py-2 absolute bottom-8 left-0 right-0 z-100 fade-in-scale">
      <div class="grow text-background">
      <%= live_flash(@flash, @kind)%>
      </div>
      <button type="button" class="self-end">
    <%= Heroicons.icon("x-mark", type: "outline", class: "w-6 text-background") %>
    </button>
    </div>
    <% end %>
    """
  end
end
