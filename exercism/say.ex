defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @base_numbers %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine"
  }

  @dozens_numbers %{
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    15 => "fifteen",
    18 => "eighteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number >= 1_000_000_000_000,
    do: {:error, "number is out of range"}
  def in_english(0), do: {:ok, "zero"}
  def in_english(number) do
    name = number
    |> number_name()
    |> String.trim()

    {:ok, name}
  end

  defp number_name(0), do: ""
  defp number_name(number) when number < 10 do
    @base_numbers[number]
  end

  defp number_name(number) when number < 100 do
    case Map.fetch(@dozens_numbers, number) do
      {:ok, name} -> name
      _ -> number_name_dozen(number)
    end
  end

  defp number_name(number) when number < 1000 do
    do_partition_number(number, "hundred", 100)
  end

  defp number_name(number) when number < 1_000_000 do
    do_partition_number(number, "thousand", 1000)
  end

  defp number_name(number) when number < 1_000_000_000 do
    do_partition_number(number, "million", 1_000_000)
  end

  defp number_name(number) when number < 1_000_000_000_000 do
    do_partition_number(number, "billion", 1_000_000_000)
  end

  defp number_name_dozen(number) when number < 20 do
    number_name(number - 10) <> "teen"
  end

  defp number_name_dozen(number) when number > 20 and number < 100 do
    dozen = div(number, 10) * 10
    unity = number - dozen

    "#{number_name(dozen)}-#{number_name(unity)}"
  end

  defp do_partition_number(number, base_name, base_number) do
    first_part = div(number, base_number)
    last_part = number - (first_part * base_number)

    "#{number_name(first_part)} #{base_name} #{number_name(last_part)}"
  end
end
