defmodule MeetupAgendaWeb.SetFirstDayTest do
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case
  import Phoenix.LiveViewTest

  test "year name render/1 renders year menu" do
    html =
      render_surface do
        ~F"""
        <MeetupAgendaWeb.Components.SetFirstDay name={1} slot={1} />
        """
      end

    assert html =~ """

             <div class=\"my_box\"></div>
             <div class=\"my_box\"></div>
             <div class=\"my_box\"></div>
           """
  end
end
