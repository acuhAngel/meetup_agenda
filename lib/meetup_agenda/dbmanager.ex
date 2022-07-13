defmodule MeetupAgenda.DBmanager do
  import Ecto.Query
  alias MeetupAgenda.{Repo, Meetups}

  def verify_complete_data(assigns) do
    assigns |> IO.inspect()

    cond do
      assigns.day_position == nil ->
        IO.puts("day position is nil")
        false

      assigns.description == nil ->
        IO.puts("description")
        false

      assigns.month == nil ->
        IO.puts("mont")
        false

      assigns.title == nil ->
        assigns.title |> IO.inspect()
        IO.puts("title")
        false

      assigns.week_day == nil ->
        IO.puts("weekday")
        false

      assigns.year == nil ->
        IO.puts("year")
        false

      true ->
        true
    end
  end

  def insert(assigns) do
    Repo.insert(%Meetups{
      title: assigns.title,
      description: assigns.description,
      year: assigns.year,
      month: assigns.month,
      day: getDayNumber(assigns.year, assigns.month, assigns.day_position, assigns.week_day),
      week_day: assigns.week_day
    })
  end

  def getMeetups(day, month, year) do
    Repo.all(
      from m in Meetups,
        where: m.year == ^year and m.month == ^month and m.day == ^day,
        select: [m.title]
    )
    |> List.flatten()
  end

  def getMeetups(month, year) do
    Repo.all(
      from m in Meetups,
        select: [m.title, m.description, m.day, m.month , m.week_day],
        where: m.year == ^year and m.month == ^month,
        order_by: [m.year, m.month, m.day]
    )
    |> Enum.map(fn x ->
        x |> List.to_tuple
    end)
  end


  def validate_date(assigns) do
    {_, start} = {assigns.year, assigns.month, 1} |> Date.from_erl()
    last = Date.end_of_month(start)

    n =
      Enum.count(
        Date.range(start, last),
        fn x ->
          x |> Date.day_of_week() == assigns.week_day
        end
      )

    if n >= assigns.week_day do
      true
    else
      false
    end
  end

  def getDayNumber(year, month, position, weekday) do
    {_, start} = {year, month, 1} |> Date.from_erl()
    last = Date.end_of_month(start)

    n =
      Enum.filter(
        Date.range(start, last),
        fn x ->
          x |> Date.day_of_week() == weekday
        end
      )
      |> List.to_tuple()
      |> elem(position - 1)

    n.day
  end
end
