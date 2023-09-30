defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  defstruct map: nil

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    enumerable
    |> remove_duplicated()
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    custom_set
    |> to_list()
    |> count()
    |> then(&(&1 == 0))
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    custom_set
    |> to_list()
    |> custom_set_contains?(element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    custom_set_1
    |> to_list()
    |> custom_set_subset?(custom_set_2)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?([], []), do: true
  def disjoint?(custom_set_1, custom_set_2) do
    custom_set_1
    |> to_list()
    |> custom_set_disjoint?(custom_set_2)
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    custom_set_1 == custom_set_2
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    element
    |> List.wrap()
    |> new()
    |> Map.merge(custom_set)
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    custom_set_1
    |> to_list()
    |> custom_set_interesection(custom_set_2)
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    custom_set_1
    |> to_list()
    |> custom_set_difference(custom_set_2)
    |> new()
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    Map.merge(custom_set_1, custom_set_2)
  end

  defp remove_duplicated(list, acc \\ %__MODULE__{})
  defp remove_duplicated([], acc), do: acc
  defp remove_duplicated([head | tail], acc) do
    acc = Map.merge(%{head => nil}, acc)

    remove_duplicated(tail, acc)
  end

  defp count(list, acc \\ 0)
  defp count([], acc), do: acc
  defp count(_list, 1), do: 1
  defp count([_head | tail], acc) do
    count(tail, acc + 1)
  end

  defp custom_set_disjoint?(list, subset_2)
  defp custom_set_disjoint?([], _subset_2), do: true
  defp custom_set_disjoint?([{num, _} | tail], subset_2) do
    case Map.fetch(subset_2, num) do
      {:ok, _} -> false
      _ -> custom_set_disjoint?(tail, subset_2)
    end
  end

  defp custom_set_contains?([], _num), do: false
  defp custom_set_contains?([{num, _} | _tail], num), do: true
  defp custom_set_contains?([_head | tail], num), do: custom_set_contains?(tail, num)

  defp custom_set_subset?([], _subset_2), do: true
  defp custom_set_subset?(_subset_1, []), do: false
  defp custom_set_subset?([{num, _} | tail], subset_2) do
    case Map.fetch(subset_2, num) do
      {:ok, _} -> custom_set_subset?(tail, subset_2)
      _ -> false
    end
  end

  defp custom_set_interesection(subset_1, subset_2, acc \\ [])
  defp custom_set_interesection(_subset_1, [], acc), do: acc
  defp custom_set_interesection([], _subset_2, acc), do: acc
  defp custom_set_interesection([{num, _} | tail], subset_2, acc) do
    case Map.fetch(subset_2, num) do
      {:ok, _} -> custom_set_interesection(tail, subset_2, [num | acc])
      _ -> custom_set_interesection(tail, subset_2, acc)
    end
  end

  defp custom_set_difference(subset_1, subset_2, acc \\ [])
  defp custom_set_difference(_subset_1, [], acc), do: acc
  defp custom_set_difference([], _subset_2, acc), do: acc
  defp custom_set_difference([{num, _} | tail], subset_2, acc) do
    case Map.fetch(subset_2, num) do
      {:ok, _} -> custom_set_difference(tail, subset_2, acc)
      _ -> custom_set_difference(tail, subset_2, [num | acc])
    end
  end

  defp to_list(custom_set) do
    custom_set
    |> Map.to_list()
    |> Enum.reject(fn {key, _val} -> key in [:map, :__struct__] end)
  end
end
