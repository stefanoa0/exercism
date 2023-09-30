defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(1), do: {:ok, :deficient}
  def classify(number) do
    max_divisor = div(number, 2)
    1..max_divisor
    |> Enum.reduce(0, fn divisor, acc ->
      if rem(number, divisor) == 0, do: acc + divisor, else: acc
    end)
    |> handle_response(number)
  end

  defp handle_response(sum_of_divisors, number) when sum_of_divisors == number, do: {:ok, :perfect}
  defp handle_response(sum_of_divisors, number) when sum_of_divisors > number, do: {:ok, :abundant}
  defp handle_response(_sum_of_divisors, _number), do: {:ok, :deficient}
end

PerfectNumbers.classify(28) |> IO.inspect()
