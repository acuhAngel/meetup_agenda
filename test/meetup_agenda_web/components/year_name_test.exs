defmodule MeetupAgendaWeb.YearNameTest do
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case
  @year 2022

  test "year name render/1 renders year menu" do
    year = @year

    html =
      render_surface do
        ~F"""
        <MeetupAgendaWeb.Components.YearName current_year={year} />
        """
      end

    assert html =~ "#{@year}"
  end
end
