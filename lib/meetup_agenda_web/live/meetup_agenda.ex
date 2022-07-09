defmodule MeetupAgendaWeb.Agenda do
  use Surface.LiveView
  # alias Surface.Components.Form
  # alias Surface.Components.Form.{TextInput, Label, Field}
  alias MeetupAgendaWeb.Components.Calendar

  def render(assigns) do
    ~F"""
    <Calendar id="month_view" />
    """
  end
end
