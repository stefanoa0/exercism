defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ", trim: true)
    |> Enum.map(fn word ->
      word
      |> vowel_sound()
      |> consonant_sound()
    end)
    |> Enum.join(" ")
  end

  defp vowel_sound(word) do
    if Regex.match?(~r/^[a|e|i|o|u|]|^(x[^aeiou]|y[^aeiou])/, word) do
      {:skip, add_ay(word)}
    else
      {:ok, word}
    end
  end

  defp consonant_sound({:skip, word}), do: word
  defp consonant_sound({:ok, word}) do
    case Regex.named_captures(~r/(?<consonant>^[^aeiou](qu)|^qu|^y|^[^aeiouy]+)/, word) do
      %{"consonant" => consonant} ->
        word
        |> move_consonant_to_end(consonant)
        |> add_ay()
      nil -> word
    end
  end

  defp add_ay(word) do
    word <> "ay"
  end

  defp move_consonant_to_end(word, consonant) do
    ~r/^[^aeiou](qu)|^qu|^y|^[^aeiouy]+/
    |> Regex.replace(word, "")
    |> Kernel.<>(consonant)
  end
end
