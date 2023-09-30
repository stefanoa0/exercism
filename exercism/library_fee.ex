defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    time = NaiveDateTime.to_time(datetime)
    case Time.compare(Time.new!(12, 0, 0, 0), time) do
      :gt -> true
      _ -> false
    end
  end

  def return_date(checkout_datetime) do
    time = if before_noon?(checkout_datetime), do: 28, else: 29
    checkout_datetime
    |> NaiveDateTime.add(time * 24 * 60 * 60, :second)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    case Date.compare(planned_return_date, actual_return_datetime) do
      :lt -> Date.diff(planned_return_date, actual_return_datetime) |> abs()
      _ -> 0
    end
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_date = datetime_from_string(checkout) |> IO.inspect()
    return_date = datetime_from_string(return) |> IO.inspect()

    late_days = checkout_date
                |> return_date()
                |> days_late(return_date) |> IO.inspect()


    if monday?(return_date) do
      trunc(rate * late_days * 0.5)
    else
      rate * late_days
    end
  end
end

LibraryFees.calculate_late_fee("2021-01-01T08:00:00Z", "2021-02-15T08:00:00Z", 111) |> IO.inspect()
