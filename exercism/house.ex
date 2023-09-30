defmodule House do
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop
    |> Enum.reduce("\n", fn num, acc -> phrase(num) <> acc)
  end

  defp phrase(1) do
    "#{this_is_the()}#{subject(1)}."
  end

  defp phrase(n) do
    n = n - 1
    sentences = Enum.reduce(n..1//-1, "", fn num, acc -> acc <> " " <> sentence(num) end)
    this_is_the() <> subject(n+1) <> sentences
  end

  defp sentence(1), do: "that lay in the #{subject(1)}"
  defp sentence(2), do: "that ate the #{subject(2)}"
  defp sentence(3), do: "that killed the #{subject(3)}"
  defp sentence(4), do: "that worried the #{subject(4)}"
  defp sentence(5), do: "that tossed the #{subject(5)}"
  defp sentence(6), do: "that milked the #{subject(6)}"
  defp sentence(7), do: "that kissed the #{subject(7)}"
  defp sentence(8), do: "that married the #{subject(8)}"
  defp sentence(9), do: "that woke the #{subject(9)}"
  defp sentence(10), do: "that kept the #{subject(10)}"
  defp sentence(11), do: "that belonged to the #{subject(11)}"
  defp subject(1), do: "house that Jack built"
  defp subject(2), do: "malt"
  defp subject(3), do: "rat"
  defp subject(4), do: "cat"
  defp subject(5), do: "dog"
  defp subject(6), do: "cow with the crumpled horn"
  defp subject(7), do: "maiden all forlorn"
  defp subject(8), do: "man all tattered and torn"
  defp subject(9), do: "priest all shaven and shorn"
  defp subject(10), do: "rooster that crowed in the morn"
  defp subject(11), do: "farmer sowing his corn"
  defp subject(12), do: "horse and the hound and the horn"
  defp this_is_the, do: "This is the "
end
