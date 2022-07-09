defmodule MeetupAgenda.DBmanager do
  import Ecto.Query
  alias Ecto.Changeset
  alias MeetupAgenda.{Repo, Meetups}

  def verify() do
    true
  end
end
