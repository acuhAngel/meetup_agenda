defmodule MeetupAgendaWeb.Components.Schedule do
  @moduledoc false
  use Surface.Component

  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput, Label, Field,RadioButton}

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
  prop target, :string, default: "#month_view"

  def render(assigns) do
    ~F"""
    <Form for={:schedule} change="change">
      <Field name="title"><Label class="title is-1" /><TextInput /></Field>
      <Field name="description"><Label class="title is-2" /><TextInput /></Field>
      <br>

      <section class="select_date">
        <div>
          <h3>
            DAY POSITION
          </h3>
          <Field name="day_position">
            {#for {w, p} <- Enum.with_index(@day_positions)}
              <Label>
                <RadioButton value={p + 1} /> {w}
              </Label>
              <br>
            {/for}
          </Field>
        </div>
        <div>
          <h3>
            DAY
          </h3>
          <Field name="weekday">
            {#for {d, p} <- Enum.with_index(@week_days)}
              <Label>
                <RadioButton value={p + 1} /> {d}<br>
              </Label>
              <br>
            {/for}
          </Field>
        </div>
        <div>
          <h3>
            MONTH
          </h3>
          <Field name="month">
            {#for {m, p} <- Enum.with_index(@months)}
              <Label>
                <RadioButton value={p + 1} /> {m}<br>
              </Label>
              <br>
            {/for}
          </Field>
        </div>
        <div>
          <h3>
            YEAR
          </h3>
          <Field name="year">
            {#for y <- 2022..2025}
              <Label>
                <RadioButton value={y} /> {y}
              </Label>
              <br>
            {/for}
          </Field>
        </div>
      </section>
    </Form>
    """
  end
end
