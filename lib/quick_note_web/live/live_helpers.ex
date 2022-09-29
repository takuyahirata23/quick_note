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
end
