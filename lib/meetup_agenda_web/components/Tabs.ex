defmodule MeetupAgendaWeb.Components.Tabs do
  @moduledoc false
  use Surface.Component
  prop name, :integer
  prop slot, :integer
  prop active, :string, default: "0"

  def render(assigns) do
    ~F"""
    <div>
      <nav class="tabs is-boxed">
        <ul>
          <li class={if(@active == "0", do: "is-active")}>
            <a :on-click="calendar" value={0}>
              <span class="icon is-small">
                <svg xmlns="http://www.w3.org/2000/svg" height="20" width="20"><path d="M6.75 15q-.208 0-.385-.167-.177-.166-.177-.395 0-.209.166-.386.167-.177.396-.177.208 0 .385.167.177.166.177.396 0 .229-.166.395Q6.979 15 6.75 15Zm0-2.875q-.208 0-.385-.167-.177-.166-.177-.375 0-.229.166-.395.167-.167.396-.167.208 0 .385.167.177.166.177.374 0 .23-.166.396-.167.167-.396.167ZM10 15q-.208 0-.385-.167-.177-.166-.177-.395 0-.209.166-.386.167-.177.396-.177.208 0 .385.167.177.166.177.396 0 .229-.166.395Q10.229 15 10 15Zm0-2.875q-.208 0-.385-.167-.177-.166-.177-.375 0-.229.166-.395.167-.167.396-.167.208 0 .385.167.177.166.177.374 0 .23-.166.396-.167.167-.396.167ZM13.25 15q-.208 0-.385-.167-.177-.166-.177-.395 0-.209.166-.386.167-.177.396-.177.208 0 .385.167.177.166.177.396 0 .229-.166.395-.167.167-.396.167Zm0-2.875q-.208 0-.385-.167-.177-.166-.177-.375 0-.229.166-.395.167-.167.396-.167.208 0 .385.167.177.166.177.374 0 .23-.166.396-.167.167-.396.167Zm-8.229 5.042q-.521 0-.854-.344-.334-.344-.334-.844V6.021q0-.5.334-.844.333-.344.854-.344h2.125V2.646h.729v2.187h4.313V2.646h.666v2.187h2.125q.521 0 .854.344.334.344.334.844v9.958q0 .5-.334.844-.333.344-.854.344Zm0-.667h9.958q.209 0 .365-.156t.156-.365V9.521h-11v6.458q0 .209.156.365t.365.156ZM4.5 8.854h11V6.021q0-.209-.156-.365t-.365-.156H5.021q-.209 0-.365.156t-.156.365Zm0 0V5.5v3.354Z" /></svg>
              </span>
              <span>
                Calendar
              </span>
            </a>
          </li>
          <li class={if(@active == "1", do: "is-active")}>
            <a :on-click="agenda" value="1">
              <svg xmlns="http://www.w3.org/2000/svg" height="20" width="20"><path d="M4.771 8.812q-.625 0-1.031-.416-.407-.417-.407-1.021V5.271q0-.604.407-1.011.406-.406 1.031-.406h10.458q.625 0 1.031.406.407.407.407 1.011v2.104q0 .604-.407 1.021-.406.416-1.031.416Zm0-.916h10.458q.209 0 .365-.167t.156-.354V5.271q0-.188-.156-.344-.156-.156-.365-.156H4.771q-.209 0-.365.156t-.156.344v2.104q0 .187.156.354.156.167.365.167Zm0 8.25q-.625 0-1.031-.406-.407-.407-.407-1.011v-2.104q0-.604.407-1.021.406-.416 1.031-.416h10.458q.625 0 1.031.416.407.417.407 1.021v2.104q0 .604-.407 1.011-.406.406-1.031.406Zm0-.917h10.458q.209 0 .365-.156t.156-.344v-2.104q0-.187-.156-.354-.156-.167-.365-.167H4.771q-.209 0-.365.167t-.156.354v2.104q0 .188.156.344.156.156.365.156ZM4.25 4.771v3.125-3.125Zm0 7.333v3.125-3.125Z" /></svg>
              Agenda
            </a>
          </li>
        </ul>
      </nav>
    </div>
    """
  end
end
