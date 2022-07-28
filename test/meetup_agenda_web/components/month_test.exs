defmodule MeetupAgendaWeb.MonthTest do
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case

  test "get the days of the current month" do
    assert MeetupAgendaWeb.Components.Month.range(2022, 7) ==
             Date.range(~D[2022-07-01], ~D[2022-07-31])
  end

  test "put the blank spaces" do
    html = render_surface do
      ~F"""
      <MeetupAgendaWeb.Components.Month current_year={2022} current_month={7} />
      """
    end

    assert html =~ "Monday"
    assert html =~ "Tuesday"
    assert html =~ "Wednesday"
    assert html =~ "Thursday"
    assert html =~ "Friday"
    assert html =~ "Saturday"
    assert html =~ "Sunday"

  end
end
