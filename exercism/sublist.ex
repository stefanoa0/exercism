defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    {_, result} = a
    |> equal_compare(b)
    |> sublist_compare(a, b)
    |> superlist_compare(a, b)

    result
  end

  defp equal_compare(a, b) when a == b do
    {:ok, :equal}
  end

  defp equal_compare(_a, _b) do
    {:error, :unequal}
  end

  defp superlist_compare({:ok, comparactive}, _a, _b), do: {:ok, comparactive}
  defp superlist_compare({:error, _comparactive}, _a, []), do: {:ok, :superlist}
  defp superlist_compare({:error, comparactive}, a, b) do
    if sublist?(b, a) do
      {:ok, :superlist}
    else
      {:ok, comparactive}
    end
  end

  defp sublist_compare({:ok, comparactive}, _a, _b), do: {:ok, comparactive}
  defp sublist_compare({:error, _comparactive}, [], _b), do: {:ok, :sublist}
  defp sublist_compare({:error, comparactive}, a, b) do
    if sublist?(a, b) do
      {:ok, :sublist}
    else
      {:error, comparactive}
    end
  end

  defp sublist?(a_list, b_list, acc \\ false)
  defp sublist?([], _b, acc), do: acc
  defp sublist?(_a, [], _acc), do: false
  defp sublist?([a_head | a_tail] = a, [b_head | b_tail], acc) do
    if a_head === b_head && compare_next(a_tail, b_tail, true) do
      true
    else
      sublist?(a, b_tail, acc)
    end
  end

  defp compare_next([], _b_tail, acc), do: acc
  defp compare_next(_a_tail, _b_tail, false), do: false
  defp compare_next([a_head | a_tail], [a_head | b_tail], acc), do: compare_next(a_tail, b_tail, acc)
  defp compare_next(_a, _b, _acc), do: false
end

Sublist.compare([1, 2, 5], [0, 1, 2, 3, 1, 2, 5, 6]) |> IO.inspect()
