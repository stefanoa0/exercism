defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """

  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    if valid?(isbn) do
      isbn
      |> String.split("", trim: true)
      |> Enum.reject(& &1 == "-")
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> Enum.reduce(0, &do_calculate/2)
      |> Kernel.rem(11)
      |> Kernel.==(0)
    else
      false
    end
  end

  defp valid?(isbn) do
    Regex.match?(isbn, ~r/(\d|X)-(\d|X){3}-(\d|X){5}-(\d|X)/)
  end

  defp do_calculate({"X", index}, acc),
    do: acc + (10 * index)

  defp do_calculate({num, index}, acc) when num in ,
    do: acc + String.to_integer(num) * index

  defp do_calculate({_n, _index}, acc), do: 0
end
