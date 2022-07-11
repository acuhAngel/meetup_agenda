defmodule MeetupAgendaWeb.Components.Calendar do
  use Surface.LiveView

  alias MeetupAgenda.DBmanager
  alias MeetupAgendaWeb.Components.{
    SetFirstDay,
    MonthName,
    MonthHeader,
    Button,
    Dialog,
    Schedule
  }

  data name_day, :integer, default: 2
  data month_days, :integer, default: 31
  data title, :string, default: nil
  data description, :string, default: nil
  data year, :integer, default: nil
  data month, :string, default: nil
  data day_position, :string, default: nil
  data week_day, :string, default: nil
  data message, :string, default: "Fill all the fields"
  data this_year, :integer

  def render(assigns) do
    ~F"""
    <section>
      <div>
        <Dialog title="Add Schedule" id="form_dialog_1" message={@message}>
          <Schedule id="add_Schedule" />
        </Dialog>
        <Button click="open_form" label="ADD SCHEDULE" />
      </div>

      <YearName year="2022" id="year" />
      <MonthName month="July" id="month" />
      <MonthHeader id="week" />

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

  def handle_event("change", %{"schedule" => schedule}, socket) do
    {
      :noreply,
      assign(
        socket,
        title: schedule["title"],
        description: schedule["description"]
      )
    }
  end

  def handle_event("day_position", %{"value" => day_position}, socket) do
    {
      :noreply,
      assign(
        socket,
        day_position: day_position |> String.to_integer
      )
    }
  end

  def handle_event("week_day", %{"value" => week_day}, socket) do
    {
      :noreply,
      assign(
        socket,
        week_day: week_day
      )
    }
  end

  def handle_event("month", %{"value" => month}, socket) do
    {
      :noreply,
      assign(
        socket,
        month: month
      )
    }
  end

  def handle_event("year", %{"value" => year}, socket) do
    {
      :noreply,
      assign(
        socket,
        year: year |> String.to_integer
      )
    }
  end





  def handle_event("schedule", _, socket) do

    if DBmanager.verify(socket.assigns)|> IO.inspect do
      Dialog.close("form_dialog_1")
      DBmanager.insert(socket.assigns)
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
      {
        :noreply,
        assign(
          socket,
          message: "QUE INGRESES TODOS LOS CAMPOS"

        )
      }
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
