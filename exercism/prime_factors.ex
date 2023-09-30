defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1), do: []
  def factors_for(number) do
    factors_for(number, 2)
  end

  defp factors_for(number, number), do: [number]
  defp factors_for(number, divisor) when rem(number, divisor) == 0 do
    [divisor | factors_for(div(number, divisor))]
  end
  defp factors_for(number, divisor) do
    factors_for(number, divisor + 1)
  end
end
