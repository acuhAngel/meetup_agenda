defmodule MeetupAgendaWeb.Components.Schedule do
  @moduledoc false
  use Surface.Component

  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput,Checkbox, TextArea, Label, Field, Select}

  prop data, :map

  def render(assigns) do
    ~F"""
    <Form for={:schedule} change="submmit">
      <Field name="title"><Label class="title is-1" /><TextInput class="input" opts={placeholder: "Title"} value={@data.title} /></Field>
      <Field name="description"><Label class="title is-2" /><TextArea class="textarea" rows="4" value={@data.description} opts={placeholder: "Description"} /></Field>
      <br>
      <div> Restrict mode?
        <Field name="restrict">
          <Label>
            <Checkbox id="restrict_mode" value={@data.restrict} opts={if(@data.restrict == true, do: [checked: "checked"], else: [])} />Yes
          </Label>
        </Field>
      </div>
      <br>
      <section class="select_date">

        <div class="select is-rounded">
          <Select
            prompt="DAY POSITION"
            selected={@data.day_position}
            field="day_position"
            options={First: 1, Second: 2, Third: 3, Fourth: 4, Fifth: 5}
          />
        </div>
        <div class="select is-rounded">
          <Select
            prompt="WEEK DAY"
            selected={@data.week_day}
            field="weekday"
            options={Monday: 1, Tuesday: 2, Wednesday: 3, Thursday: 4, Friday: 5, Saturday: 6, Sunday: 7}
          />
        </div>
        <div class="select is-rounded">
          <Select
            prompt="MONTH"
            selected={@data.month}
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
        <div class="select is-rounded">
          <Select
            prompt="YEAR"
            selected={@data.year}
            field="year"
            options={Date.utc_today().year..(Date.utc_today().year + 10)}
          />
        </div>
      </section>
    </Form>
    """
  end
end
