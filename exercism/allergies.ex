defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @allergies_scores %{
    1 => "eggs",
    2 => "peanuts",
    4 => "shellfish",
    8 => "strawberries",
    16 => "tomatoes",
    32 => "chocolate",
    64 => "pollen",
    128 => "cats",
  }

  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    do_list(flags)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    item in do_list(flags)
  end

  defp do_list(flag, acc \\ [])
  defp do_list(flag, acc) when flag > 256, do: do_list(flag - 256, acc)
  defp do_list(0, acc), do: acc
  defp do_list(flag, acc) do
    case Map.fetch(@allergies_scores, flag) do
      {:ok, allergie} -> [allergie | acc]
      _ ->
        score = next_score(flag)
        acc = do_list(score, acc)
        do_list(flag - score, acc)
    end
  end

  defp next_score(flag) do
    Map.keys(@allergies_scores)
    |> Enum.reverse()
    |> Enum.find(&(flag - &1 >= 0))
  end
end
