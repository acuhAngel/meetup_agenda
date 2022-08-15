defmodule MeetupAgendaWeb.ButtonTest do
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case

  test "Tabs render/1 renders the menu tabs" do
    html =
      render_surface do
        ~F"""
        <MeetupAgendaWeb.Components.Button
          click={"schedule", target: :live_view}
          label="Schedule!"
          kind="primary"
          disabled="false"
        />
        """
      end

    assert html =~ """
           <button phx-click=\"schedule\" type=\"button\" class=\"button is-normal is-primary\">
             Schedule!
           </button>
           """
  end
end
