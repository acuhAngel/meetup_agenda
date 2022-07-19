defmodule MeetupAgenda.DBmanager do
  @moduledoc false
  import Ecto.Query
  alias MeetupAgenda.{Repo, Meetups}

  def verify_complete_data(assigns) do
    # assigns |> IO.inspect()

    cond do
      assigns.day_position == nil ->
        IO.puts("day position is nil")
        false

      assigns.month == nil ->
        IO.puts("mont")
        false

      assigns.title == "" ->
        assigns.title
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
      year: assigns.year |> String.to_integer(),
      month: assigns.month |> String.to_integer(),
      day:
        get_day_number(
          assigns.year |> String.to_integer(),
          assigns.month |> String.to_integer(),
          assigns.day_position |> String.to_integer(),
          assigns.week_day |> String.to_integer()
        ),
      week_day: assigns.week_day |> String.to_integer()
    })
  end

  def get_meetups(day, month, year) do
    Repo.all(
      from m in Meetups,
        where: m.year == ^year and m.month == ^month and m.day == ^day,
        select: [m.title]
    )
    |> List.flatten()
  end

  def get_meetups(month, year) do
    Repo.all(
      from m in Meetups,
        select: [m.id, m.title, m.description, m.day, m.month, m.week_day],
        where: m.year == ^year and m.month == ^month,
        order_by: [m.year, m.month, m.day]
    )
    |> Enum.map(fn x ->
      x |> List.to_tuple()
    end)
  end

  def validate_date(assigns) do
    year = assigns.year |> String.to_integer()
    month = assigns.month |> String.to_integer()

    day =
      get_day_number(
        year,
        month,
        assigns.day_position |> String.to_integer(),
        assigns.week_day |> String.to_integer()
      )

    IO.puts("hay repetudos? ")

    exist =
      (Repo.all(
         from m in Meetups,
           where: m.year == ^year and m.month == ^month and m.day == ^day
       ) >= 1)
      # |> IO.inspect()

    IO.puts("restrict")
    assigns.restrict
    # |> IO.inspect()

    if exist and assigns.restrict do
      false
    else
      {_, start} =
        {year, month, 1}
        |> Date.from_erl()

      last = Date.end_of_month(start)

      n =
        Enum.count(
          Date.range(start, last),
          fn x ->
            x |> Date.day_of_week() == assigns.week_day |> String.to_integer()
          end
        )

      if n >= assigns.week_day |> String.to_integer() do
        true
      else
        false
      end
    end
  end

  def get_day_number(year, month, position, weekday) do
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

  def delete(id) do
    Repo.delete_all(from m in Meetups, where: m.id == ^id)
  end
end
