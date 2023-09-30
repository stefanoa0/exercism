defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  # For want of a nail the shoe was lost.
  # For want of a shoe the horse was lost.
  # For want of a horse the rider was lost.
  # For want of a rider the message was lost.
  # For want of a message the battle was lost.
  # For want of a battle the kingdom was lost.
  # And all for the want of a nail.

  @spec recite(strings :: [String.t()]) :: String.t()
  def recite(strings) do
    phrases = phrase(strings, nil)
    first_phrase = List.first(phrases)
    phrases
    |> Enum.drop(1)
    |> Kernel.++([first_phrase])
    |> Enum.join("\n")
  end

  defp phrase([], _), do: []
  defp phrase([word | tail], previous) do
    [sentence(word, previous) | phrase(tail, word)]
  end

  defp sentence(word, nil) do
    "And all for the want of a #{word}.\n"
  end

  defp sentence(word_1, word_2) do
    "For want of a #{word_2} the #{word_1} was lost."
  end
end
