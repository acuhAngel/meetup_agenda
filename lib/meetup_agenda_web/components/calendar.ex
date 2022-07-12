defmodule MeetupAgendaWeb.Components.Calendar do
  use Surface.LiveView

  alias MeetupAgenda.DBmanager

  alias MeetupAgendaWeb.Components.{
    Month,
    Button,
    Dialog,
    Schedule,
    MonthName
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
  data schedule_btn_status, :string, default: "true"
  data current_year, :integer, default: Date.utc_today().year
  data current_month, :integer, default: Date.utc_today().month

  def render(assigns) do
    ~F"""
    <section>
      <div>
        <Dialog title="Add Schedule" id="form_dialog_1" message={@message} button_disabled="false">
          <Schedule />
        </Dialog>
        <Button click="open_form" label="ADD SCHEDULE" />
      </div>
      <div class="title container is-max-desktop">
        {@current_year}
      </div>
      <Month month={@current_month} id="current_month" />
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
        day_position: day_position |> String.to_integer()
      )
    }
  end

  def handle_event("week_day", %{"value" => week_day}, socket) do
    {
      :noreply,
      assign(
        socket,
        week_day: week_day |> String.to_integer()
      )
    }
  end

  def handle_event("month", %{"value" => month}, socket) do
    {
      :noreply,
      assign(
        socket,
        month: month |> String.to_integer()
      )
    }
  end

  def handle_event("year", %{"value" => year}, socket) do
    {
      :noreply,
      assign(
        socket,
        year: year |> String.to_integer()
      )
    }
  end

  def handle_event("schedule", _, socket) do
    if DBmanager.verify_complete_data(socket.assigns) |> IO.inspect() and
         DBmanager.validate_date(socket.assigns) do
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

  def handle_event("next_month", _, socket) do
    if socket.assigns.current_month < 12 do
      {
        :noreply,
        assign(
          socket,
          current_month: (socket.assigns.current_month + 1) |> IO.inspect()
        )
      }
    else
      {
        :noreply,
        assign(
          socket,
          current_month: 1,
          current_year: socket.assigns.current_year + 1
        )
      }
    end
  end

  def handle_event("prev_month", _, socket) do
    if socket.assigns.current_month > 1 do
      {
        :noreply,
        assign(
          socket,
          current_month: (socket.assigns.current_month - 1) |> IO.inspect()
        )
      }
    else
      {
        :noreply,
        assign(
          socket,
          current_month: 12,
          current_year: socket.assigns.current_year - 1
        )
      }
    end
  end
end
