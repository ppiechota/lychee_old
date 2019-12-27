defmodule LycheeWeb.Helpers.IconHelper do
  @moduledoc """
  Give some icons to be used on templates.
  """
  use Phoenix.HTML
  alias LycheeWeb.Router.Helpers, as: Routes

  def icon_tag(conn, name, opts \\ []) do
    classes = Keyword.get(opts, :class, "") <> " icon"
    content_tag(:svg, class: classes) do
      tag(:use, "href": Routes.static_path(conn, "/images/icons.svg#" <> name))
    end
  end

  def button_tag(conn, name, opts \\ []) do
    optional_classes = Keyword.get(opts, :class, "")
    classes = "self-end shadow bg-gray-700 text-white rounded-lg px-4 py-2 ml-2 font-medium focus:outline-none focus:shadow-outline " <> optional_classes
    type = Keyword.get(opts, :type, "")

    content_tag(:button, [class: classes, type: type]) do
      name
    end
  end
end
