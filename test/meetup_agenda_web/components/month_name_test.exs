defmodule MeetupAgendaWeb.MonthNameTest do
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case

  @months [
    "ERROR",
    "JANUARY",
    "FEBRUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGUST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER"
  ]

  for {month, i} <- @months |> Enum.with_index() do
    @month month
    @i i
    test "month #{@month} render/1 renders " do
      pos = @i

      html =
        render_surface do
          ~F"""
          <MeetupAgendaWeb.Components.MonthName month={pos} />
          """
        end

      assert html =~ "#{@month}"
    end
  end
end
