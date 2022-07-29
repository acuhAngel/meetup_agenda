defmodule MeetupAgendaWeb.Components.Dialog do
  @moduledoc false
  use Surface.LiveComponent
  alias Surface.Components.Form.Checkbox
  alias MeetupAgendaWeb.Components.Button

  prop title, :string, required: true
  prop ok_label, :string, default: "Ok"
  prop close_label, :string, default: "Close"
  prop ok_click, :event, default: "close"
  prop close_click, :event, default: "close"
  prop message, :string, default: "fill all the fields."
  prop button_disabled, :string, default: "true"
  prop required, :boolean, default: false

  data show, :boolean, default: false

  slot default

  def render(assigns) do
    ~F"""
    <div class={"modal", "is-active": @show} :on-window-keydown={@close_click} phx-key="Escape">
      <div class="modal-background" />
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">{@title}</p>
          <label class="subtitle">
          </label>
        </header>
        <section class="modal-card-body">
          <#slot />
        </section>
        <footer class="modal-card-foot" style="justify-content: flex-end">
          <div class="row">
            <p>{@message}</p>

            <div>
              <Button
                id="schedule"
                click={"schedule", target: :live_view}
                label="Schedule!"
                kind="primary"
                disabled={@button_disabled}
              />
              <Button id="close_dialog" click={@close_click} kind="danger">{@close_label}</Button>
            </div>
          </div>
        </footer>
      </div>
    </div>
    """
  end

  # Public API

  def open(dialog_id) do
    send_update(__MODULE__, id: dialog_id, show: true)
  end

  def close(dialog_id) do
    send_update(__MODULE__, id: dialog_id, show: false)
  end

  # Default event handlers

  def handle_event("close", _, socket) do
    {:noreply, assign(socket, show: false)}
  end
end
