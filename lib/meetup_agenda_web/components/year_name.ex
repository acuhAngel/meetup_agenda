defmodule MeetupAgendaWeb.Components.YearName do
  @moduledoc false
  use Surface.Component

  alias MeetupAgendaWeb.Components.{Button}
  prop current_year, :integer, required: true

  def render(assigns) do
    ~F"""
    <div>
      <Button kind="" click="prev_year" label="<" />
      <Button kind="danger">
        {@current_year}
      </Button>
      <Button kind="" click="next_year" label=">" />
    </div>
    """
  end
end
