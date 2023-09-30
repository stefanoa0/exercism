defmodule FoodChain do
  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop
    |> Enum.map(fn num ->
      first_phrase(num)
      <> second_phrase(num)
      <> render_third_phrases(num)
      <> last_phrase(num)
    end)
    |> Enum.join("\n")
  end

  defp render_third_phrases(8), do: ""
  defp render_third_phrases(num) do
    Enum.reduce(1..num, "", fn numb, acc -> third_phrase(numb) <> acc end)
  end

  defp first_phrase(num) do
    "I know an old lady who swallowed a #{object(num)}.\n"
  end

  defp second_phrase(2) do
    "It #{sentence()}.\n"
  end
  defp second_phrase(3) do
    "How absurd to swallow a #{object(3)}!\n"
  end
  defp second_phrase(4) do
    "Imagine that, to swallow a #{object(4)}!\n"
  end
  defp second_phrase(5) do
    "What a hog, to swallow a #{object(5)}!\n"
  end
  defp second_phrase(6) do
    "Just opened her throat and swallowed a #{object(6)}!\n"
  end
  defp second_phrase(7) do
    "I don't know how she swallowed a #{object(7)}!\n"
  end
  defp second_phrase(_), do: ""

  defp third_phrase(1), do: ""
  defp third_phrase(3) do
    "She swallowed the #{object(3)} to catch the #{object(2)} that #{sentence()}.\n"
  end
  defp third_phrase(num) do
    "She swallowed the #{object(num)} to catch the #{object(num - 1)}.\n"
  end

  defp last_phrase(8) do
    "She's dead, of course!\n"
  end
  defp last_phrase(_n) do
    "I don't know why she swallowed the #{object(1)}. Perhaps she'll die.\n"
  end

  defp sentence do
    "wriggled and jiggled and tickled inside her"
  end

  defp object(1), do: "fly"
  defp object(2), do: "spider"
  defp object(3), do: "bird"
  defp object(4), do: "cat"
  defp object(5), do: "dog"
  defp object(6), do: "goat"
  defp object(7), do: "cow"
  defp object(8), do: "horse"
end
