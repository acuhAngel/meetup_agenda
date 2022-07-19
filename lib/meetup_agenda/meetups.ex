defmodule MeetupAgenda.Meetups do
  @moduledoc false
  use Ecto.Schema

  schema "meetups" do
    field :title, :string
    field :description, :string
    field :year, :integer
    field :month, :integer
    field :day, :integer
    field :week_day, :integer
  end
end
