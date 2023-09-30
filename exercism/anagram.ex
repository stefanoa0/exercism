defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.reject(&compare_strings?(&1, base))
    |> Enum.filter(fn word ->
      word
      |> str_to_sorted_list()
      |> Kernel.==(str_to_sorted_list(base))
      |> dbg()
    end)
  end

  defp str_to_sorted_list(str) do
    str
    |> String.downcase()
    |> String.split("")
    |> Enum.sort()
    |> Enum.join("")
  end

  defp compare_strings?(str1, str2) do
    String.downcase(str1) == String.downcase(str2)
  end
end

Anagram.match("Orchestra", ~w(cashregister carthorse radishes)) |> IO.inspect()
