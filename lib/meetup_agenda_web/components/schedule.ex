defmodule MeetupAgendaWeb.Components.Schedule do
  use Surface.Component

  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput, Label, Field, Checkbox}

  prop days, :list,
    default: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  prop months, :list,
    default: [
      "January",
      " February",
      " march",
      " April",
      " May",
      " June",
      " July",
      " August",
      " September",
      " October",
      " November",
      "December"
    ]

  prop day_positions, :list, default: ["First", "Second", "Third", "Fourth", "Fifth"]
  prop this_year, :integer, default: 2022
  # prop meetup, :map, default: %{
  #   "title" => "schedule",
  #   "description" => "description",
  #   "year" => 2022,
  #   "month" => "January",
  #   "day_position" => "First",
  #   "day" => "Monday"
  # }
  def render(assigns) do
    ~F"""
    <Form for={:meetup} change="change" opts={autocomplete: "off"}>
      <Field name="title"><Label class="title is-1" /><TextInput /></Field>
      <Field name="description"><Label class="title is-2" /><TextInput /></Field>
      <br>

      <section class="select_date">
<div>
          <h3>
            YEAR
          </h3>
          {#for y <- 2022..2025}
            <Field name="year">
              <Label>
                <Checkbox checked_value={y} /> {y}
              </Label>
            </Field> <br>
          {/for}
          </div>
          <div>
          <h3>
            MONTH
          </h3>

          {#for m <- @months}
            <Field name="month">
              <Label>
                <Checkbox
                  value="2022"
                  checked_value={m}
                  unchecked_value="2024"
                  capture_click={"month", target: "#month_view"}
                /> {m}<br>
              </Label>
            </Field><br>
          {/for}
</div>
<div>
          <h3>
            DAY POSITION
          </h3>
          {#for w <- @day_positions}
            <Field name="day_position">
              <Label>
                <Checkbox checked_value={w} click="day" /> {w}
              </Label>
            </Field>
            <br>
          {/for}
          </div>
<div>
          <h3>
            DAY
          </h3>
          {#for d <- @days}
            <Field name="day">
              <Label>
                <Checkbox checked_value={d} click="day" /> {d}<br>
              </Label>
            </Field><br>
          {/for}
</div>
      </section>
      <Button click="schedule" label="Schedule!" kind="primary"  />
    </Form>
    """
  end
end
