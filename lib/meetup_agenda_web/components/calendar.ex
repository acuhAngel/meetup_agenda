defmodule MeetupAgendaWeb.Components.Calendar do
  use Surface.LiveView
  alias MeetupAgenda.DBmanager

  alias MeetupAgendaWeb.Components.{
    SetFirstDay,
    MonthName,
    CalendarHeader,
    Button,
    Dialog,
    Schedule
  }

  data name_day, :integer, default: 2
  data month_days, :integer, default: 31
  data title, :string
  data description, :string
  data year, :integer
  data month, :string
  data day_position, :string
  data day, :string

  def render(assigns) do
    ~F"""
    <section>
      <div>
        <Dialog title="Add Schedule" id="form_dialog_1">
          <Schedule id="add_Schedule" />
        </Dialog>
        <Button click="open_form" label="ADD SCHEDULE" />
      </div>

      <MonthName month="July" id="month" />
      <CalendarHeader id="week" />

      <div class="calendar-container">
        {#for day <- 1..@month_days}
          {#if day == 1}
            <SetFirstDay name={@name_day} slot={1} />
          {/if}
          <div class="box">{day}</div>
        {/for}
      </div>
    </section>
    """
  end

  def handle_event("open_form", _, socket) do
    Dialog.open("form_dialog_1")
    {:noreply, socket}
  end

  def handle_event("change", data, socket) do
    IO.inspect(data)

    {
      :noreply,
      assign(
        socket,
        title: "HOLA"
      )
    }
  end

  def handle_event("year", %{"value" => year}, socket) do
    {
      :noreply,
      assign(
        socket,
        year: year
      )
    }
  end

  def handle_event("month", data, socket) do
    IO.inspect(data)

    {
      :noreply,
      assign(
        socket,
        month: ""
      )
    }
  end

  def handle_event("day_position", %{"value" => day_position}, socket) do
    {
      :noreply,
      assign(
        socket,
        day_position: day_position
      )
    }
  end

  def handle_event("day", %{"value" => day}, socket) do
    {
      :noreply,
      assign(
        socket,
        day: day
      )
    }
  end

  def handle_event("schedule", _, socket) do
    if DBmanager.verify() do
      {
        :noreply,
        assign(
          socket,
          title: "",
          description: "",
          year: "",
          month: "",
          day_position: "",
          day: ""
        )
      }
    else
    end
  end

  def handle_event("close", _, socket) do
    {
      :noreply,
      assign(
        socket,
        title: "",
        description: "",
        year: "",
        month: "",
        day_position: "",
        day: ""
      )
    }
  end
end
