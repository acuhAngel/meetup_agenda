defmodule MeetupAgenda.DBmanager do
  import Ecto.Query
  alias Ecto.Changeset
  alias MeetupAgenda.{Repo, Meetups}

  def verify(assigns) do
    assigns |> IO.inspect
    cond do
      assigns.day_position == nil ->
        IO.puts("dayposition")
        IO.inspect assigns.day_position
        false
      assigns.description == nil ->
        IO.puts("description")
        false
      assigns.month == nil ->
        IO.puts("mont")
        false
      assigns.title == nil ->
        IO.puts("title")
        false
      assigns.week_day == nil ->
        IO.puts("weekday")
        false
      assigns.year == nil ->
        IO.puts("year")
        false
      true -> true
    end

  end

  def insert(assigns) do
    Repo.insert(%Meetups{
      title: assigns.title,
      description: assigns.description,
      year: assigns.year,
      month: assigns.month,
      week_days: assigns.week_day,
      day: assigns.day_position
    })
  end
end
