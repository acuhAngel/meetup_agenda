defmodule MeetupAgendaWeb.Components.Month do
  @moduledoc false
  use Surface.Component
  alias MeetupAgendaWeb.Components.SetFirstDay
  alias MeetupAgenda.DBmanager
  alias Surface.Components.LivePatch

  prop week, :list,
    default: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  prop current_year, :integer, default: 2022
  prop current_month, :integer, default: 5
  prop update, :integer

  def render(assigns) do
    ~F"""
    <section>
      <div class="calendar-container">
        {#for name <- @week}
          <div class="my_box">{name}</div>
        {/for}
        {#for day <- range(@current_year, @current_month)}
          {#if day.day == 1}
            <SetFirstDay name={day |> Date.day_of_week()} slot={1} />
          {/if}
          <div class="my_box">
            <div>{day.day}</div>
            {#for {id, meet} <- DBmanager.get_meetups(day.day, @current_month, @current_year)}
              <LivePatch to={"/agenda/#{id}"} label={meet} />
            {/for}
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
