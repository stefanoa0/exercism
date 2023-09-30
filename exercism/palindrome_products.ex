defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)
  def generate(max_factor, min_factor) when min_factor > max_factor,
    do: raise ArgumentError
  def generate(max_factor, min_factor) do
    list = Enum.to_list(min_factor..max_factor)

    list
    |> generate_all_product_between(list)
    |> get_max_min()
  end

  defp generate_all_product_between(list, list_2, acc \\ %{})
  defp generate_all_product_between([], [], acc), do: acc
  defp generate_all_product_between([_head], [], acc), do: acc
  defp generate_all_product_between([], [_head | tail_2] = list_2, acc),
    do: generate_all_product_between(list_2, tail_2, acc)

  defp generate_all_product_between([head | tail], [head_2 | _tail_2] = list_2, acc) do
    product_of = head * head_2

    if palindrome?(product_of) do
      factors_list = Enum.sort([head, head_2])
      factors = %{product_of => [factors_list]}
      acc = Map.merge(acc, factors, fn _key, val1, val2 ->
        val1 ++ val2
      end)
      generate_all_product_between(tail, list_2, acc)
    else
      generate_all_product_between(tail, list_2, acc)
    end
  end

  defp palindrome?(num) do
    num
    |> Integer.to_string()
    |> then(&(&1 == String.reverse(&1)))
  end

  defp get_max_min(map) when map_size(map) > 1 do
    Map.new([Enum.max(map), Enum.min(map)])
  end
  defp get_max_min(map), do: map
end
