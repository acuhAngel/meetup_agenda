defmodule MeetupAgenda.Repo.Migrations.CreateMeetupsTable do
  use Ecto.Migration

  def change do
    create table(:meetups, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :description, :string
      add :year, :integer
      add :month, :string
      add :week_days, :string
      add :day, :integer
    end
  end
end
