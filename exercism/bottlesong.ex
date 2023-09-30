defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """
  @number_names %{
    0 => "no",
    1 => "One",
    2 => "Two",
    3 => "Three",
    4 => "Four",
    5 => "Five",
    6 => "Six",
    7 => "Seven",
    8 => "Eight",
    9 => "Nine",
    10 => "Ten"
  }

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    end_bottle = start_bottle - take_down + 1
    Enum.map(start_bottle..end_bottle//-1, fn n ->
      "#{first_phrase(n)}#{second_phrase()}#{third_phrase(n)}"
    end)
    |> Enum.join("\n")
    |> String.trim()
  end

  defp first_phrase(n) do
    "#{@number_names[n]} green #{plural(n)} hanging on the wall,\n" |> String.duplicate(2)
  end

  defp second_phrase() do
    "And if one green bottle should accidentally fall,\n"
  end

  defp third_phrase(n) do
    "There'll be #{String.downcase(@number_names[n - 1])} green #{plural(n - 1)} hanging on the wall.\n"
  end

  defp plural(1), do: "bottle"
  defp plural(_n), do: "bottles"
end
