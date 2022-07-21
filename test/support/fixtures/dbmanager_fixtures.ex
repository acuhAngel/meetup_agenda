defmodule MeetupAgenda.DBmanagerFixtures do
  @moduledoc """
  this modulo helps to probe dbmanager
  """
  alias MeetupAgenda.{Repo, Meetups}

  def meet_fixture(:meet) do
    Repo.insert(%Meetups{
      title: "title 1",
      description: "description 1",
      year: 2022,
      month: 7,
      day: 4,
      week_day: 1
    })
  end
end
