defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    coins
    |> Enum.sort(:desc)
    |> do_change(target, [])
    |> handle_change()
  end

  defp do_change(_coins, target, _charge_coins) when target < 0, do: {:error, "cannot change"}
  defp do_change([], target, _charge_coins) when target > 0, do: {:error, "cannot change"}
  defp do_change(_coins, 0, charge_coins), do: charge_coins

  defp do_change([head | tail], target, charge_coins) when head > target do
    do_change(tail, target, charge_coins)
  end

  defp do_change([head | _tail] = list, target, charge_coins) do
    new_target = target - head
    do_change(list, new_target, charge_coins ++ [head])
  end

  defp handle_change({:error, error}), do: {:error, error}
  defp handle_change(change), do: {:ok, Enum.sort(change, :asc)}
end
