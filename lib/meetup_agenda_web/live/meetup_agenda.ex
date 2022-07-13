defmodule MeetupAgendaWeb.Agenda do
  use Surface.LiveView
  # alias Surface.Components.Form
  # alias Surface.Components.Form.{TextInput, Label, Field}
  alias MeetupAgendaWeb.Components.{Calendar, Tabs}
  data active, :string, default: "0"

  def render(assigns) do
    ~F"""
    <Tabs active={@active} />
    <section class="tabcontent">
      {#if @active == "0"}
        <div class="tab-item animated slideInRight faster">
          <br>
          <Calendar id="month_view" />
        </div>
      {#else}
        <br>
        <div class="tab-item animated slideInRight faster">
          <MeetupAgendaWeb.Components.Agenda id="agenda_view" />
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
end
