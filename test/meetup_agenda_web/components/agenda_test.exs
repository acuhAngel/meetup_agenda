defmodule MeetupAgendaWeb.AgendaTest do
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case

  @months [
    "ERROR",
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ]

  @weekdays [
    "error",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
    "SUN"
  ]

  for {month, i} <- @months |> Enum.with_index(),
      {weekday, j} <- @weekdays |> Enum.with_index() do
    @month month
    @i i
    @j j
    @wd weekday
    test "month #{@month} #{weekday} render " do
      m = @i
      w = @j

      html =
        render_surface do
          ~F"""
          <MeetupAgendaWeb.Components.Agenda month={[{1, "test title", "test description", 1, m, w}]} />
          """
        end

      assert html =~ "#{@month},\n        #{@wd}"
    end
  end
end
