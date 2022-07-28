defmodule MeetupAgendaWeb.TabsTest do
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case

  test "Tabs render/1 renders the menu tabs" do
    html =
      render_surface do
        ~F"""
        <MeetupAgendaWeb.Components.Tabs active="0" />
        """
      end

    assert html =~ "<li id=\"calendar_tab\" class=\"is-active\">"
  end
end
