defmodule MeetupAgendaWeb.Components.MonthName do
  @moduledoc false
  use Surface.Component

  alias MeetupAgendaWeb.Components.{Button}
  prop month, :string, default: "January"
  prop target, :string, default: "month_view"

  def render(assigns) do
    ~F"""
    <div class="">
      <Button kind="" click="prev_month" label="<" />
      <span class="button">
        {case @month do
          1 -> "JANUARY"
          2 -> "FEBRUARY"
          3 -> "MARCH"
          4 -> "APRIL"
          5 -> "MAY"
          6 -> "JUNE"
          7 -> "JULY"
          8 -> "AUGUST"
          9 -> "SEPTEMBER"
          10 -> "OCTOBER"
          11 -> "NOVEMBER"
          12 -> "DECEMBER"
          _ -> "ERROR"
        end}
      </span>
      <Button kind="" click="next_month" label=">" />
    </div>
    """
  end
end
