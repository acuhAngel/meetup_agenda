defmodule MeetupAgenda.DBmanager do
  @moduledoc false
  import Ecto.Query
  alias MeetupAgenda.{Repo, Meetups}

  def verify_complete_data(assigns) do
    # assigns |> IO.inspect()

    cond do
      assigns.day_position == nil ->
        {"day position can not remain empty", false}

      assigns.month == nil ->
        {"mont can not remain empty", false}

      assigns.title == "" ->
        {"title can not remain empty", false}

      assigns.week_day == nil ->
        {"weekday can not remain empty", false}

      assigns.year == nil ->
        {"year can not remain empty", false}

      true ->
        {:ok, true}
    end
  end

  def insert(assigns) do
    Repo.insert(%Meetups{
      title: assigns.title,
      description: assigns.description,
      year: assigns.year,
      month: assigns.month,
      day:
        get_day_number(
          assigns.year,
          assigns.month,
          assigns.day_position,
          assigns.week_day
        ),
      week_day: assigns.week_day
    })
  end

  def get_meetups(day, month, year) do
    Repo.all(
      from m in Meetups,
        where: m.year == ^year and m.month == ^month and m.day == ^day,
        select: [m.id, m.title]
    )
    |> Enum.map(fn x ->
      x |> List.to_tuple()
    end)
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
    year = assigns.year
    month = assigns.month

    day =
      get_day_number(
        year,
        month,
        assigns.day_position,
        assigns.week_day
      )

    if day != false do
      exist =
        Repo.all(
          from m in Meetups,
            where: m.year == ^year and m.month == ^month and m.day == ^day
        )
        |> length >= 1

      if exist and assigns.restrict do
        {"already a meet on this date", false}
      else
        {_, start} =
          {year, month, 1}
          |> Date.from_erl()

        last = Date.end_of_month(start)

        n =
          Enum.count(
            Date.range(start, last),
            fn x ->
              x |> Date.day_of_week() == assigns.week_day
            end
          )

        # |> IO.inspect()

        if n >= assigns.day_position do
          {"ok", true}
          # |> IO.inspect()
        else
          {"this date doestn exist", false}
        end
      end
    else
      {"this date doestn exist", false}
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

    if Enum.count(n) >= position do
      elem(n |> List.to_tuple(), position - 1).day
    else
      false
    end
  end

  def delete(id) do
    Repo.delete_all(from m in Meetups, where: m.id == ^id)
  end

  def get_details(nil) do
    %{title: nil, description: nil, id: nil}
  end

  def get_details(id) do
    Repo.get(Meetups, id)
  end
end
