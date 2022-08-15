defmodule MeetupAgendaWeb.MeetDetailsTest do
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case

  test "meet description modal" do
    html =
      render_surface do
        ~F"""
        <MeetupAgendaWeb.Components.MeetDetails meet={%{title: "test title", description: "test description", id: 1}} />
        """
      end

    assert html =~ "test title"
    assert html =~ "test description"
  end
end
