defmodule MeetupAgendaWeb.Agenda do
@moduledoc false

  use Surface.LiveView
  # alias Surface.Components.Form
  # alias Surface.Components.Form.{TextInput, Label, Field}
  alias MeetupAgenda.DBmanager

  alias MeetupAgendaWeb.Components.{
    YearName,
    Tabs,
    MonthName,
    Dialog,
    Schedule,
    Button,
    Month,
    Agenda
  }

  data active, :string, default: "1"
  data message, :string, default: "fill all the fields."
  data current_year, :integer, default: Date.utc_today().year
  data current_month, :integer, default: Date.utc_today().month
  data title, :string, default: nil
  data description, :string, default: nil
  data year, :integer, default: nil
  data month, :string, default: nil
  data day_position, :string, default: nil
  data week_day, :string, default: nil
  data restrict, :boolean, default: false
  data meets, :any, default: []

  def render(assigns) do
    ~F"""
    <Dialog
      target="agenda_view"
      title="Add Schedule"
      id="form_dialog_1"
      message={@message}
      button_disabled="false"
    >
      <Schedule />
    </Dialog>
    <div class="row">
      <div>
      </div>
      <div>
        <YearName current_year={@current_year} />
        <MonthName month={@current_month} target="agenda_view" />
      </div>
      <Button kind="primary" click="open_form" label="ADD SCHEDULE" />
    </div>
    <Tabs active={@active} />
    <section class="tabcontent">
      {#if @active == "0"}
        <div class="tab-item animated slideInRight faster">
          <br>
          <Month current_month={@current_month} />
        </div>
      {#else}
        <br>
        <div class="tab-item animated slideInRight faster">
          <Agenda month={@meets} />
        </div>
      {/if}
    </section>
    """
  end

  def handle_event("calendar", _, socket) do
    {:noreply,
     assign(
       socket,
       active: "0"
     )}
  end

  def handle_event("agenda", _, socket) do
    {:noreply,
     assign(
       socket,
       active: "1"
     )}
  end

  def handle_event("open_form", _, socket) do
    Dialog.open("form_dialog_1")
    {:noreply, socket}
  end

  def handle_event("change", %{"schedule" => schedule}, socket) do
    # schedule |> IO.inspect()

    {
      :noreply,
      assign(
        socket,
        title: schedule["title"],
        description: schedule["description"],
        day_position: schedule["day_position"],
        week_day: schedule["weekday"],
        month: schedule["month"],
        year: schedule["year"]
      )
    }
  end

  def handle_event("schedule", _, socket) do
    if DBmanager.verify_complete_data(socket.assigns) and
         DBmanager.validate_date(socket.assigns) do
      Dialog.close("form_dialog_1")

      DBmanager.insert(socket.assigns)

      {
        :noreply,
        assign(
          socket,
          title: nil,
          description: nil,
          year: nil,
          month: nil,
          day_position: nil,
          day: nil,
          restrict: false,
          meets: DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year)
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

  def handle_event("delete", %{"value" => id}, socket) do
    DBmanager.delete(id)

    {
      :noreply,
      assign(
        socket,
        meets: DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year)
      )
    }
  end

  def handle_event("close", _, socket) do
    {
      :noreply,
      assign(
        socket,
        title: nil,
        description: nil,
        year: nil,
        month: nil,
        day_position: nil,
        day: nil
      )
    }
  end

  def handle_event("next_month", _, socket) do
    if socket.assigns.current_month < 12 do
      {
        :noreply,
        assign(
          socket,
          current_month: socket.assigns.current_month + 1,
          meets:
            DBmanager.get_meetups(socket.assigns.current_month + 1, socket.assigns.current_year)
        )
      }
    else
      {
        :noreply,
        assign(
          socket,
          current_month: 1,
          current_year: socket.assigns.current_year + 1,
          meets:
            DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year + 1)
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
          current_month: socket.assigns.current_month - 1,
          meets:
            DBmanager.get_meetups(socket.assigns.current_month - 1, socket.assigns.current_year)
        )
      }
    else
      {
        :noreply,
        assign(
          socket,
          current_month: 12,
          current_year: socket.assigns.current_year - 1,
          meets:
            DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year - 1)
        )
      }
    end
  end

  def handle_event("next_year", _, socket) do
    {
      :noreply,
      assign(
        socket,
        current_year: socket.assigns.current_year + 1,
        meets: DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year + 1)
      )
    }
  end

  def handle_event("prev_year", _, socket) do
    {
      :noreply,
      assign(
        socket,
        current_year: socket.assigns.current_year - 1,
        meets: DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year - 1)
      )
    }
  end

  def handle_event("required", data, socket) do
    # IO.inspect(data)
    if data["value"] |> is_nil do
      {
        :noreply,
        assign(
          socket,
          restrict: false
        )
      }
    else
      # IO.inspect(data["value"])

      {
        :noreply,
        assign(
          socket,
          restrict: true
        )
      }
    end
  end
end
