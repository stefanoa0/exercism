defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    if String.length(number_string) < size || size < 1 do
      raise ArgumentError
    else
      do_largest_product(number_string, size)
    end
  end

  defp do_largest_product(number_string, size) do
    string_size = String.length(number_string)

    (0..string_size - 1)
    |> Enum.map(fn initial ->
      slice_num = initial..(initial + size - 1)

      number_string
      |> String.slice(slice_num)
      |> product_of_string(size)
    end)
    |> Enum.max()
  end

  defp product_of_string(string, size) do
    if String.length(string) < size, do: 0, else: product_of_string(string)
  end

  defp product_of_string(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reduce(1, fn num, acc ->
      acc * String.to_integer(num)
    end)
  end
end

Series.largest_product("52677741234314237566414902593461595376319419139427", 6)
