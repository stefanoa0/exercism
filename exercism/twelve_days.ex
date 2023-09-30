defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @nth %{
    1 => "first",
    2 => "second",
    3 => "third",
    4 => "fourth",
    5 => "fifth",
    6 => "sixth",
    7 => "seventh",
    8 => "eighth",
    9 => "ninth",
    10 => "tenth",
    11 => "eleventh",
    12 => "twelfth"
  }

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    objects =
      number..1//-1
      |> Enum.reduce("", fn
        1, acc ->  "#{acc}#{object(1)}"
        2, acc -> "#{acc}#{object(2)}, and "
        num, acc -> "#{acc}#{object(num)}, "
      end)

    number
    |> sentence()
    |> Kernel.<>(objects)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.reduce("", fn num, acc -> acc <> verse(num) <> "\n"  end)
    |> String.trim()
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp sentence(day) do
    "On the #{@nth[day]} day of Christmas my true love gave to me: "
  end

  defp object(1), do:
    "a Partridge in a Pear Tree."
  defp object(2), do:
    "two Turtle Doves"
  defp object(3), do:
    "three French Hens"
  defp object(4), do:
    "four Calling Birds"
  defp object(5), do:
    "five Gold Rings"
  defp object(6), do:
    "six Geese-a-Laying"
  defp object(7), do:
    "seven Swans-a-Swimming"
  defp object(8), do:
    "eight Maids-a-Milking"
  defp object(9), do:
    "nine Ladies Dancing"
  defp object(10), do:
    "ten Lords-a-Leaping"
  defp object(11), do:
    "eleven Pipers Piping"
  defp object(12), do:
    "twelve Drummers Drumming"
end
