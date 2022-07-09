defmodule MeetupAgendaWeb.Components.MonthName do
  use Surface.LiveComponent
  prop month, :string, default: "January"

  def render(assigns) do
    ~F"""
    <div class="title">
      {@month}
    </div>
    """
  end
end
