defmodule MeetupAgendaWeb.Components.Tabs do
  @moduledoc false
  use Surface.Component
  prop active, :string, default: "0"

  def render(assigns) do
    ~F"""
    <nav class="tabs is-boxed">
      <ul>
        <li id="calendar_tab" class={if(@active == "0", do: "is-active")}>
          <a id="calendar_select" :on-click="calendar">
            <span class="material-symbols-outlined">
              calendar_month
            </span>
            <span>
              Calendar
            </span>
          </a>
        </li>
        <li id="agenda_tab" class={if(@active == "1", do: "is-active")}>
          <a id="agenda_select" :on-click="agenda">
            <span class="material-symbols-outlined">
              view_agenda
            </span>
            <span>
              Agenda
            </span>
          </a>
        </li>
      </ul>
    </nav>
    """
  end
end
