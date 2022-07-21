defmodule MeetupAgendaWeb.Components.Agenda do
  @moduledoc false
  use Surface.Component
  # alias MeetupAgenda.DBmanager
  alias MeetupAgendaWeb.Components.Button
  prop message, :string, default: "Fill all the fields"
  prop month, :any, []

  def render(assigns) do
    ~F"""
    <div>
      {#for {id, title, description, day, month, weekday} <- @month
        }
        <div class="agenda_container my_box">
          <div class="agenda-day is-size-3">
            {day}
          </div>
          <div class="is-size-7">
            {case month do
              1 -> "JAN"
              2 -> "FEB"
              3 -> "MAR"
              4 -> "APR"
              5 -> "MAY"
              6 -> "JUN"
              7 -> "JUL"
              8 -> "AUG"
              9 -> "SEP"
              10 -> "OCT"
              11 -> "NOV"
              12 -> "DEC"
              _ -> "ERROR"
            end},
            {case weekday do
              1 -> "MON"
              2 -> "TUE"
              3 -> "WED"
              4 -> "THU"
              5 -> "FRI"
              6 -> "SAT"
              7 -> "SUN"
            end}</div>
          <div class="agenda-title is-size-4">
            {title}
          </div>
          <p class="agenda-description">
            {description}
          </p>
          <div class="buttons are-small agenda-button">
            <Button kind="danger" click="delete" value={id} label="delete" />
          </div>
        </div>
      {/for}
    </div>
    """
  end
end
