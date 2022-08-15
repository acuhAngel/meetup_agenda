defmodule MeetupAgenda.DBmanagerTest do
  use ExUnit.Case
  use MeetupAgenda.DataCase
  alias MeetupAgenda.DBmanager
  import MeetupAgenda.DBmanagerFixtures

  @data [
    %{
      title: "title 1",
      description: "description 1",
      year: 2022,
      month: 7,
      day_position: 1,
      week_day: 1,
      restrict: false,
      result: {:ok, true}
    },
    %{
      title: "",
      description: "description 2",
      year: 2022,
      month: 7,
      day_position: 1,
      week_day: 1,
      restrict: false,
      result: {"title can not remain empty", false}
    },
    %{
      title: "title 2",
      description: "description 2",
      year: nil,
      month: 7,
      day_position: 1,
      week_day: 1,
      restrict: true,
      result: {"year can not remain empty", false}
    },
    %{
      title: "title 2",
      description: "description 2",
      year: 2022,
      month: nil,
      day_position: 1,
      week_day: 1,
      restrict: true,
      result: {"mont can not remain empty", false}
    },
    %{
      title: "title 2",
      description: "description 2",
      year: 2022,
      month: 7,
      day_position: nil,
      week_day: 1,
      restrict: true,
      result: {"day position can not remain empty", false}
    },
    %{
      title: "title 2",
      description: "description 2",
      year: 2022,
      month: 7,
      day_position: 1,
      week_day: nil,
      restrict: true,
      result: {"weekday can not remain empty", false}
    }
  ]

  @valid_data %{
    title: "title 2",
    description: "description 2",
    year: 2022,
    month: 7,
    day_position: 1,
    week_day: 1,
    restrict: true,
    result: {"already a meet on this date", false}
  }

  @invalid_data %{
    title: "title 2",
    description: "description 2",
    year: 2022,
    month: 7,
    day_position: 5,
    week_day: 1,
    restrict: true,
    result: {"this date doestn exist", false}
  }

  @valid_data2 %{
    title: "title 2",
    description: "description 2",
    year: 2022,
    month: 7,
    day_position: 1,
    week_day: 1,
    restrict: false,
    result: {"ok", true}
  }

  for {i, assigns} <- @data |> Enum.with_index(fn element, index -> {index, element} end) do
    @assigns assigns
    @i i
    test "verify_complete_data #{@i}" do
      assert DBmanager.verify_complete_data(@assigns) == @assigns.result
    end
  end

  test "validate date with restrict" do
    meet_fixture(:meet)
    assert DBmanager.validate_date(@valid_data) == @valid_data.result
  end

  test "validate date" do
    assert DBmanager.validate_date(@valid_data2) == @valid_data2.result
  end

  test "validate date doesnt exist" do
    assert DBmanager.validate_date(@invalid_data) == @invalid_data.result
  end

  test "get day number correct" do
    assert DBmanager.get_day_number(2022, 7, 1, 1) == 4
  end

  test "get day number incorrect" do
    assert DBmanager.get_day_number(2022, 7, 5, 1) == false
  end

  test "get metups by day" do
    meet_fixture(:meet)
    [{_x, title}] = DBmanager.get_meetups(4, 7, 2022)
    assert title == "title 1"
  end

  test "get metups month" do
    meet_fixture(:meet)
    [meet] = DBmanager.get_meetups(7, 2022)
    assert meet |> elem(1) == "title 1"
    assert meet |> elem(2) == "description 1"
  end

  test "delete meet" do
    {_, meet} = meet_fixture(:meet)
    assert DBmanager.delete(meet.id) == {1, nil}
  end

  test "insert" do
    {:ok, meet} =
      DBmanager.insert(%{
        title: "title 1",
        description: "description 1",
        year: 2022,
        month: 7,
        day_position: 1,
        week_day: 5
      })

    assert meet.title == "title 1"
    assert meet.description == "description 1"
    assert meet.year == 2022
    assert meet.month == 7
    assert meet.day == 1
    assert meet.week_day == 5
  end
end
