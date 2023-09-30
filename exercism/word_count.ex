defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    ~r/[,\s.: !&@$%^&_]/
    |> Regex.split(String.downcase(sentence))
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.trim(&1, "'"))
    |> count_words()
  end

  defp count_words(list, map_acc \\ %{})
  defp count_words([], map_acc), do: map_acc
  defp count_words([word | tail], map_acc) do
    map_acc = Map.update(map_acc, word, 1, &(&1 + 1))

    count_words(tail, map_acc)
  end
end
