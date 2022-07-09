defmodule MeetupAgendaWeb.Components.CalendarHeader do
  use Surface.LiveComponent

  data week, :list,
    default: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  def render(assigns) do
    ~F"""
    <div class="calendar-container">
      {#for name <- @week}
        <section class="box">{name}</section>
      {/for}
    </div>
    """
  end
end
