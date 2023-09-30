defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number = String.replace(number, " ", "")
    if Regex.match?(~r/^[\d]{2,}$/, number) do
      number
      |> String.reverse()
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn
        {num, index} when rem(index, 2) != 0 ->
          num
          |> String.to_integer()
          |> Kernel.*(2)
          |> then(fn
            num when num > 9 -> num - 9
            num -> num
            end)
        {num, _} -> String.to_integer(num)
      end)
      |> Enum.sum()
      |> then(&(rem(&1, 10) == 0))
    else
      false
    end
  end
end
