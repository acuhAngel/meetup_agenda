defmodule MeetupAgenda.Meetups do
  use Ecto.Schema

  schema "meetup" do
    field :title, :string
    field :description, :string
    field :year, :integer
    field :month, :string
    field :week_days, :string
    field :day, :integer
  end
end
