defmodule MeetupAgendaWeb.Components.MeetDetails do
  @moduledoc false
  use Surface.Component
  alias MeetupAgendaWeb.Components.Button
  alias Surface.Components.LivePatch

  prop meet, :map, required: true
  prop close_click, :event, default: "close"
  prop show, :boolean, default: false

  def render(assigns) do
    ~F"""
    <div class={"modal", "is-active": @show} :on-window-keydown={@close_click} phx-key="Escape">
      <div class="modal-background"> </div>
      <div class="modal-card">
        <header class="modal-card-head">
          {@meet.title}
        </header>
        <section class="modal-card-body">
          {@meet.description}
        </section>

        <footer class="modal-card-foot">
          <div class="buttons are-small agenda-button">
            <Button id="delete" kind="danger" label="delete" click="delete" value={@meet.id} />
            <Button id="ok" kind="primary" click="close"><LivePatch to="/agenda" label="ok" /></Button>
          </div>
        </footer>
      </div>
    </div>
    """
  end
end
