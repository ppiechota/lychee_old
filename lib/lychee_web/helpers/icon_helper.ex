defmodule LycheeWeb.Helpers.IconHelper do
  @moduledoc """
  Give some icons to be used on templates.
  """
  use Phoenix.HTML
  # use Phoenix.HTML.Form
  alias LycheeWeb.Router.Helpers, as: Routes

  def icon_tag(conn, name, opts \\ []) do
    classes = Keyword.get(opts, :class, "") <> " icon"

    content_tag(:svg, class: classes) do
      tag(:use, href: Routes.static_path(conn, "/images/icons.svg#" <> name))
    end
  end

  def btn(name, opts \\ [])

  def btn(name, :submit) do
    class = "self-end shadow bg-blue-400 text-white rounded-lg px-4
      py-2 ml-2 font-medium focus:outline-none focus:shadow-outline"

    content_tag(:button, class: class, type: "submit") do
      name
    end
  end

  def btn(name, opts) do
    to = Keyword.get(opts, :to, "")
    method = Keyword.get(opts, :method, :get)

    class = "self-end shadow bg-blue-400 text-white rounded-lg px-4
      py-2 ml-2 font-medium focus:outline-none focus:shadow-outline"

    link(name, to: to, class: class, method: method)
  end

  def input_tag(form, field, text) do
    di_cl = "flex flex-row py-3 items-center"
    lb_cl = "w-24 mr-2"
    ti_cl = "shadow rounded-lg px-4 py-2 focus:outline-none focus:shadow-outline"

    content_tag(:div, class: di_cl) do
      [label(form, field, text, class: lb_cl), text_input(form, field, class: ti_cl)]
    end
  end
end
