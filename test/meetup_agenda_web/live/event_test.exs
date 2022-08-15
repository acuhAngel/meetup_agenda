defmodule MeetupAgendaWeb.EventTest do
  import Plug.Conn
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  use MeetupAgendaWeb.ConnCase
  use Surface.LiveViewTest
  use ExUnit.Case
  @endpoint MeetupAgendaWeb.Endpoint
  @next_month (case Date.utc_today().month + 1 do
                 13 -> "JANUARY"
                 2 -> "FEBRUARY"
                 3 -> "MARCH"
                 4 -> "APRIL"
                 5 -> "MAY"
                 6 -> "JUNE"
                 7 -> "JULY"
                 8 -> "AUGUST"
                 9 -> "SEPTEMBER"
                 10 -> "OCTOBER"
                 11 -> "NOVEMBER"
                 12 -> "DECEMBER"
                 _ -> "ERROR"
               end)
  @prev_month (case Date.utc_today().month - 1 do
                 1 -> "JANUARY"
                 2 -> "FEBRUARY"
                 3 -> "MARCH"
                 4 -> "APRIL"
                 5 -> "MAY"
                 6 -> "JUNE"
                 7 -> "JULY"
                 8 -> "AUGUST"
                 9 -> "SEPTEMBER"
                 10 -> "OCTOBER"
                 11 -> "NOVEMBER"
                 0 -> "DECEMBER"
                 _ -> "ERROR"
               end)

  test "get and change view", %{conn: conn} do
    {:ok, view, html} = live(conn, "/agenda")
    assert html =~ "<li id=\"calendar_tab\" class=\"is-active\">"

    assert view
           |> element("#agenda_select")
           |> render_click() =~ "<li id=\"agenda_tab\" class=\"is-active\">"

    assert view
           |> element("#calendar_select")
           |> render_click() =~ "<li id=\"calendar_tab\" class=\"is-active\">"
  end

  test "launch modal", %{conn: conn} do
    {:ok, view, html} = live(conn, "/agenda")
    assert html =~ "class=\"modal\" phx-key=\"Escape\""

    assert view
           |> element("[phx-click=\"open_form\"]")
           |> render_click() =~ "class=\"modal\""
  end

  test "close modal", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/agenda")

    assert view
           |> element("#close_dialog")
           |> render_click() =~ "class=\"modal\""
  end

  test "next month", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/agenda")

    assert view
           |> element("[phx-click=\"next_month\"]")
           |> render_click() =~ """
           #{@next_month}
           """
  end

  test "next year", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/agenda")

    assert view
           |> element("[phx-click=\"next_year\"]")
           |> render_click() =~ """
           #{Date.utc_today().year + 1}
           """
  end

  test "prev month", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/agenda")

    assert view
           |> element("[phx-click=\"prev_month\"]")
           |> render_click() =~ """
             #{@prev_month}
           """
  end

  test "prev year", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/agenda")

    assert view
           |> element("[phx-click=\"prev_year\"]")
           |> render_click() =~ """
           #{Date.utc_today().year - 1}
           """
  end

end
