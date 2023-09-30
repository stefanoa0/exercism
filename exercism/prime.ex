defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise ArgumentError
  def nth(count) do
    1..10001
    |> Stream.map(fn num ->
      if prime?(num), do: num, else: false
    end)
    |> Stream.reject(&(&1 == false))
    |> Enum.take(count)
    |> List.last()
  end

  defp prime?(1), do: false
  defp prime?(test_number) when test_number in [2, 3], do: true
  defp prime?(test_number) do
    max_divisor = div(test_number, 2)
    2..max_divisor
    |> Enum.all?(fn divisor ->
      rem(test_number, divisor) != 0
    end)
  end
end
