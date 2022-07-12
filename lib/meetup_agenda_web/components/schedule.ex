defmodule MeetupAgendaWeb.Components.Schedule do
  use Surface.Component

  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput, Label, Field, Checkbox}

  prop week_days, :list,
    default: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  prop months, :list,
    default: [
      "January",
      "February",
      "march",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ]

  prop day_positions, :list, default: ["First", "Second", "Third", "Fourth", "Fifth"]
  prop this_year, :integer, default: 2022

  def render(assigns) do
    ~F"""
    <Form for={:schedule} change="change">
      <Field name="title"><Label class="title is-1" /><TextInput /></Field>
      <Field name="description"><Label class="title is-2" /><TextInput /></Field>
      <br>
    </Form>
    <section class="select_date">
      <div>
        <h3>
          DAY POSITION
        </h3>
        {#for {w, p} <- Enum.with_index(@day_positions)}
          <Label>
            <Checkbox
              unchecked_value="nil"
              checked_value={p + 1}
              click={"day_position", target: "#month_view"}
            /> {w}
          </Label>
          <br>
        {/for}
      </div>
      <div>
        <h3>
          DAY
        </h3>
        {#for {d, p} <- Enum.with_index(@week_days)}
          <Label>
            <Checkbox checked_value={p + 1} click={"week_day", target: "#month_view"} /> {d}<br>
          </Label>
          <br>
        {/for}
      </div>
      <div>
        <h3>
          MONTH
        </h3>
        {#for {m, p} <- Enum.with_index(@months)}
          <Label>
            <Checkbox checked_value={p + 1} click={"month", target: "#month_view"} /> {m}<br>
          </Label>
          <br>
        {/for}
      </div>
      <div>
        <h3>
          YEAR
        </h3>
        {#for y <- 2022..2025}
          <Label>
            <Checkbox checked_value={y} click={"year", target: "#month_view"} /> {y}
          </Label>
          <br>
        {/for}
      </div>
    </section>
    """
  end
end
