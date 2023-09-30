defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    input
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> do_transpose()
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.join("\n")
  end

  defp do_transpose([" ", " "] = list) do
    []
  end
  defp do_transpose(matrix) do
    firsts = Enum.map(matrix, &(first/1))
    rests = Enum.map(matrix, &(rest/1))
    [firsts | do_transpose(rests)] |> IO.inspect()
  end

  defp first(" "), do: " "
  defp first([]), do: ""
  defp first(list), do: hd(list)

  defp rest(" "), do: " "
  defp rest([]), do: " "
  defp rest(list), do: tl(list)
end
