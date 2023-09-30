defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_digits, _input_base, output_base) when output_base < 2,
    do: {:error, "output base must be >= 2"}
  def convert(_digits, input_base, _output_base) when input_base < 2,
    do: {:error, "input base must be >= 2"}
  def convert([], _input_base, _output_base), do: {:ok, [0]}
  def convert([0], _input_base, _output_base), do: {:ok, [0]}

  def convert(digits, input_base, output_base) do
    if digits_valid_to_input_base?(digits, input_base) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      {:ok, do_convert(digits, input_base, output_base)}
    end
  end

  defp do_convert(digits, input_base, 10) do
    digits = Enum.reverse(digits)

    {digits, 0}
    |> to_decimal_converter(input_base)
    |> Integer.digits()
  end

  defp do_convert(digits, 10, output_base) do
    digits
    |> Enum.join()
    |> String.to_integer()
    |> from_decimal_converter(output_base)
  end

  defp do_convert(digits, input_base, output_base) do
    digits
    |> do_convert(input_base, 10)
    |> do_convert(10, output_base)
  end

  defp from_decimal_converter(number, output_base, output_digits \\ [])

  defp from_decimal_converter(0, _output_base, []), do: [0]

  defp from_decimal_converter(0, _output_base, output_digits) do
    Enum.reverse(output_digits)
  end

  defp from_decimal_converter(number, output_base, output_digits) do
    new_number = div(number, output_base)
    rest = rem(number, output_base)
    output_digits = output_digits ++ [rest]

    from_decimal_converter(new_number, output_base, output_digits)
  end

  defp to_decimal_converter(digits, input_base, acc \\ 0)

  defp to_decimal_converter({[], _index}, _input_base, acc) do
    acc
  end

  defp to_decimal_converter({[head | tail], index}, input_base, acc) do
    acc = acc + (head * Integer.pow(input_base, index))

    to_decimal_converter({tail, index + 1}, input_base, acc)
  end

  defp digits_valid_to_input_base?(digits, base) do
    Enum.any?(digits, fn digit -> digit < 0 || digit >= base end)
  end
end


AllYourBase.convert([0, 0, 0], 10, 2) |> IO.inspect()
