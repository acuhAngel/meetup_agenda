defmodule MeetupAgendaWeb.AgendaLive do
  @moduledoc false
  use Surface.LiveView

  alias MeetupAgenda.DBmanager

  alias MeetupAgendaWeb.Components.{
    YearName,
    Tabs,
    MonthName,
    Dialog,
    Schedule,
    Button,
    Month,
    Agenda,
    MeetDetails
  }

  data active, :string, default: "0"
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
  data update, :integer, default: 0
  data meet_description, :any, default: %{title: nil, description: nil, id: nil}

  def render(assigns) do
    ~F"""
    <br>
    <br>
    <Dialog
      title="Add Schedule"
      id="form_dialog_1"
      message={@message}
      button_disabled="false"
      required={@restrict}
    >
      <Schedule data={%{
        title: @title,
        description: @description,
        year: @year,
        month: @month,
        day_position: @day_position,
        week_day: @week_day,
        restrict: @restrict
      }} />
    </Dialog>
    {#if @live_action == :show}
      <MeetDetails meet={@meet_description} show />
    {/if}

    <div class="row">
      <div>
      </div>
      <div>
        <YearName current_year={@current_year} />
        <MonthName month={@current_month} target="agenda_view" />
      </div>
      <Button id="open_modal" kind="primary" click="open_form" label="ADD SCHEDULE" />
    </div>
    <Tabs active={@active} />
    <section class="tabcontent">
      {#if @active == "0"}
        <div class="container is-max-desktop">
          <br>
          <Month current_month={@current_month} current_year={@current_year} update={@update} />
        </div>
      {#else}
        <br>
        <div class="container is-max-desktop">
          <Agenda month={DBmanager.get_meetups(@current_month, @current_year)} update={@update} />
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

  def handle_event("submmit", %{"schedule" => schedule}, socket) do
    IO.puts("formulariio")

    # schedule
    # |> IO.inspect()
    # schedule
    # |> IO.inspect()
    # IO.puts("SOCKET")
    # socket |> IO.inspect()

    {
      :noreply,
      assign(
        socket,
        title: schedule["title"],
        description: schedule["description"],
        day_position:
          if(schedule["day_position"] != "", do: schedule["day_position"] |> String.to_integer()),
        week_day: if(schedule["weekday"] != "", do: schedule["weekday"] |> String.to_integer()),
        month: if(schedule["month"] != "", do: schedule["month"] |> String.to_integer()),
        year: if(schedule["year"] != "", do: schedule["year"] |> String.to_integer()),
        restrict: schedule["restrict"]
      )
    }
  end

  def handle_event("schedule", _, socket) do
    {mensaje, complete_data} = DBmanager.verify_complete_data(socket.assigns)

    if complete_data do
      {mensaje, valid_data} = DBmanager.validate_date(socket.assigns)

      if valid_data do
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
            week_day: nil,
            restrict: false,
            update: socket.assigns.update + 1,
            meets:
              DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year)
          )
        }
      else
        {
          :noreply,
          assign(
            socket,
            message: mensaje
          )
        }
      end
    else
      {
        :noreply,
        assign(
          socket,
          message: mensaje
        )
      }
    end
  end

  def handle_event("delete", %{"value" => id}, socket) do
    DBmanager.delete(id)

    {:noreply,
     socket
     |> push_patch(to: "/agenda")
     |> assign(
       update: socket.assigns.update + 1,
       live_action: :main,
       meets: DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year)
     )}
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
        meets:
          DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year + 1)
      )
    }
  end

  def handle_event("prev_year", _, socket) do
    {
      :noreply,
      assign(
        socket,
        current_year: socket.assigns.current_year - 1,
        meets:
          DBmanager.get_meetups(socket.assigns.current_month, socket.assigns.current_year - 1)
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

  def handle_params(params, _url, socket) do
    # socket |> IO.inspect
    {:noreply,
     socket
     |> assign(:meet_description, DBmanager.get_details(params["id"]))}
  end
end
