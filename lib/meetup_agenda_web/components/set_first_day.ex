defmodule MeetupAgendaWeb.Components.SetFirstDay do
  use Surface.Component
  prop name, :integer
  prop slot, :integer

  def render(assigns) do
    ~F"""
    {#if @slot != @name}
      <div class="button is-success is-light" />
      {render(%{
        __context__: %{},
        name: @name,
        slot: @slot + 1
      })}
    {/if}
    """
  end
end
