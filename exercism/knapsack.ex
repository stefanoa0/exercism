defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value([], _maximum_weight), do: 0
  def maximum_value(items, maximum_weight) do
    items
    |> Enum.sort_by(& &1.value, :desc)
    |> sum_while(maximum_weight)
    |> then(fn
      [] -> 0
      list ->
        list
        |> Enum.max()
        |> then(fn %{value: value} -> value end)
    end)
  end

  defp sum_while(list, list_2, max_weight, acc \\ %{}, list_acc \\ [])
  defp sum_while([], _list_2, _max_weight, _acc, list_acc), do: list_acc
  defp sum_while(_list_1, [], _max_weight, _acc, list_acc), do: list_acc
  defp sum_while([head | _tail] = list, [head_2 | tail_2], max_weight, acc, list_acc)  do
    %{weight: weight} = new_acc = Map.merge(head, head_2, fn _key, val1, val2 ->
      val1 + val2
    end)


    if weight <= max_weight do
      list_acc = [new_acc | list_acc]
      IO.inspect(list_acc, label: 1)
      sum_while(tail, max_weight, new_acc, list_acc)
    else
      if head.weight < max_weight do
        list_acc = [head | list_acc]
        IO.inspect(list_acc, label: 2)
        sum_while(tail, max_weight, acc, list_acc)
      else
        IO.inspect(list_acc, label: 3)
        sum_while(tail, max_weight, acc, list_acc)
      end
    end
  end
end
Knapsack.maximum_value([
  %{value: 350, weight: 25},
  %{value: 400, weight: 35},
  %{value: 450, weight: 45},
  %{value: 20, weight: 5},
  %{value: 70, weight: 25},
  %{value: 8, weight: 3},
  %{value: 5, weight: 2},
  %{value: 5, weight: 2}
], 104)
|> IO.inspect()
