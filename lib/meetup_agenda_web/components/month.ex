defmodule MeetupAgendaWeb.Components.Month do
  use Surface.LiveComponent
  alias MeetupAgendaWeb.Components.{MonthName, SetFirstDay}
  alias MeetupAgenda.DBmanager

  data week, :list,
    default: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  prop year, :integer, default: 2022
  prop month, :integer, default: 5

  def render(assigns) do
    ~F"""
    <section>
      <MonthName month={@month} id="month" />

      <div class="calendar-container">
        {#for name <- @week}
          <div class="my_box">{name}</div>
        {/for}
        {#for day <- range(@year, @month)}
          {#if day.day == 1}
            <SetFirstDay name={day |> Date.day_of_week()} slot={1} />
          {/if}
          <div class="my_box">
            <div>{day.day}</div>
            <div class="">
              {#for meet <- DBmanager.getMeetups(day.day, @month, @year)}
                * {meet}
              {/for}
            </div>
          </div>
        {/for}
      </div>
    </section>
    """
  end

  def range(year, month) do
    {_, start} = {year, month, 1} |> Date.from_erl()
    last = Date.end_of_month(start)
    Date.range(start, last)
  end
end
