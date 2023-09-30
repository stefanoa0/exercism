defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    [3, 5, 7]
    |> Enum.reduce("", &factor(&1, &2, number))
    |> handle_response(number)
  end

  defp factor(3, acc, number) do
    if factor?(number, 3), do: acc <> "Pling", else: acc
  end

  defp factor(5, acc, number) do
    if factor?(number, 5), do: acc <> "Plang", else: acc
  end

  defp factor(7, acc, number) do
    if factor?(number, 7), do: acc <> "Plong", else: acc
  end

  defp factor?(number, factor), do: rem(number, factor) == 0

  defp handle_response("", number), do: Integer.to_string(number)
  defp handle_response(response, _number), do: response
end
