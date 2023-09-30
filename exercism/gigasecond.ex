defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @gigasecond 10 ** 9

  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    date = Date.new!(year, month, day)
    time = Time.new!(hours, minutes, seconds, 0)
    date
    |> DateTime.new!(time)
    |> DateTime.add(@gigasecond, :second)
    |> handle_response()
  end

  defp handle_response(%DateTime{year: year, month: month, day: day, hour: hours, minute: minutes, second: seconds}) do
    {{year, month, day}, {hours, minutes, seconds}}
  end
end


Gigasecond.from({{2011, 4, 25}, {0, 0, 0}})
|> IO.inspect()
