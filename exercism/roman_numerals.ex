defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(0), do: ""

  def numeral(number) when number < 4 do
    String.duplicate("I", number)
  end

  def numeral(number) when number == 4, do: numeral(1) <> numeral(5)

  def numeral(number) when number >= 5 and number < 9 do
    unit = number - 5
    "V" <> numeral(unit)
  end

  def numeral(9), do: numeral(1) <> numeral(10)

  def numeral(number) when number in [10, 20, 30] do
    number = div(number, 10)
    String.duplicate("X", number)
  end

  def numeral(40), do: numeral(10) <> numeral(50)

  def numeral(number) when number > 10 and number < 50 do
    numeral(number, 10)
  end

  def numeral(number) when number >= 50 and number < 90 do
    "L" <> numeral(number - 50)
  end

  def numeral(number) when number >= 90 and number < 100 do
    "XC" <> numeral(number - 90)
  end

  def numeral(400), do: numeral(100) <> numeral(500)

  def numeral(number) when number in [100, 200, 300] do
    number = div(number, 100)
    String.duplicate("C", number)
  end

  def numeral(number) when number > 100 and number < 499 do
    numeral(number, 100)
  end

  def numeral(number) when number >= 500 and number < 900 do
    "D" <> numeral(number - 500)
  end

  def numeral(number) when number >= 900 and number < 1000 do
    "CM" <> numeral(number - 900)
  end

  def numeral(number) when number in [1000, 2000, 3000] do
    number = div(number, 1000)
    String.duplicate("M", number)
  end

  def numeral(number) when number > 1000 and number < 4000 do
    numeral(number, 1000)
  end

  defp numeral(number, size) do
    number_size = number
    |> rem(size)
    |> numeral()

    number
    |> div(size)
    |> Kernel.*(size)
    |> numeral()
    |> Kernel.<>(number_size)
  end
end
