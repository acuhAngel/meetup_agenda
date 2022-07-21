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
  prop target, :string, default: "#month_view"
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
            restrict mode
            <Checkbox
              opts={if(@required, do: [checked: true], else: [checked: false])}
              class="switch-button__checkbox"
              checked_value="true"
              click={"required", target: :live_view}
            />
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
                click={"schedule", target: :live_view}
                label="Schedule!"
                kind="primary"
                disabled={@button_disabled}
              />
              <Button click={@close_click} kind="danger">{@close_label}</Button>
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
