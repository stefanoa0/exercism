defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  defimpl String.Chars, for: Clock do
    def to_string(%Clock{hour: hour, minute: minute}) do
      hour = Integer.to_string(hour) |> String.pad_leading(2, "0")
      minute = Integer.to_string(minute) |> String.pad_leading(2, "0")
      "#{hour}:#{minute}"
    end
  end

  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    {hour, minute} = set_minute(minute, hour)
    hour = set_hour(hour)

    %__MODULE__{
      hour: hour,
      minute: minute
    }
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
  end

  defp set_hour(hour) when hour > 0 and hour <= 23 do
    hour
  end

  defp set_hour(hour) when hour < 0 do
    set_hour((24 + hour))
  end

  defp set_hour(hour), do: rem(hour, 12)

  defp set_minute(minute, hour) when minute > 0 and minute <= 59 do
    {hour, minute}
  end

  defp set_minute(minute, hour) when minute == -60 do
    set_minute(0, hour - 1)
  end

  defp set_minute(minute, hour) when minute < 0 do
    minutes = 60 + rem(minute, 60)
    hour = hour - ceil((minute / 60) * -1)

    set_minute(minutes, hour)
  end

  defp set_minute(minute, hour) do
    hour = hour + div(minute, 60)
    minute = rem(minute, 60)
    {hour, minute}
  end
end
