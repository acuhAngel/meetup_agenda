defmodule MeetupAgendaWeb.Components.Schedule do
  @moduledoc false
  use Surface.Component

  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput, Label, Field, RadioButton, Select}

  prop day_positions, :list, default: []
  prop this_year, :integer, default: 2022
  prop target, :string, default: "#month_view"
  prop data, :map

  def render(assigns) do
    ~F"""
    <Form for={:schedule} change="change">
      <Field name="title"><Label class="title is-1" /><TextInput /></Field>
      <Field name="description"><Label class="title is-2" /><TextInput /></Field>
      <br>
      <section class="select_date">
        <div>
          <Select
            prompt="DAY POSITION"
            field="day_position"
            options={First: 1, Second: 2, Third: 3, Fourth: 4, Fifth: 5}
          />
        </div>
        <div>
          <Select
            prompt="WEEK DAY"
            field="weekday"
            options={Monday: 1, Tuesday: 2, Wednesday: 3, Thursday: 4, Friday: 5, Saturday: 6, Sunday: 7}
          />
        </div>
        <div>
          <Select
            prompt="MONTH"
            selected={@data["month"]}
            field="month"
            options={
              January: 1,
              February: 2,
              march: 3,
              April: 4,
              May: 5,
              June: 6,
              July: 7,
              August: 8,
              September: 9,
              October: 10,
              November: 11,
              December: 12
            }
          />
        </div>
        <div>
          <Select prompt="YEAR" field="year" options={"2022": 2022, "2023": 2023, "2024": 2024} />
        </div>
      </section>
    </Form>
    """
  end
end
