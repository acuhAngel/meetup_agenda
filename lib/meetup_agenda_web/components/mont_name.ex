defmodule MeetupAgendaWeb.Components.MonthName do
  use Surface.LiveComponent

  alias MeetupAgendaWeb.Components.{Button}
  prop month, :string, default: "January"
  prop target, :string, default: "month_view"
  def render(assigns) do
    ~F"""
    <div class="title container is-max-desktop">
      <Button kind="danger" click={"prev_month", target: "##{@target}"}>{"<"}</Button>
      <Button kind="info">
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
      </Button>
      <Button kind="success" click={"next_month", target: "##{@target}"}>{">"}</Button>
    </div>
    """
  end
end
