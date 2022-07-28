defmodule MeetupAgendaWeb.DialogTest do
  @moduledoc """
  this module test the components and functions functionality of the Dialog component
  """
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  test "dialog button", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/agenda")

    assert view
           |> element("#schedule")
           |> render_click()

    assert view
           |> element("#close_dialog")
           |> render_click()
  end

  test "dialog functions" do
    assert MeetupAgendaWeb.Components.Dialog.open("form_dialog_1") ==
             {:phoenix, :send_update,
              {MeetupAgendaWeb.Components.Dialog, "form_dialog_1",
               %{id: "form_dialog_1", show: true}}}

    assert MeetupAgendaWeb.Components.Dialog.close("form_dialog_1") ==
             {:phoenix, :send_update,
              {MeetupAgendaWeb.Components.Dialog, "form_dialog_1",
               %{id: "form_dialog_1", show: false}}}
  end
end
