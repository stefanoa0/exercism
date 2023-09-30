defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, String.t()}
  def convert(input) do
    input
    |> Enum.chunk_every(4)
    |> Enum.map(fn rows ->
      rows
      |> Enum.map(fn row ->
        row
        |> String.split("", trim: true)
        |> Enum.chunk_every(3)
        |> Enum.map(&Enum.join(&1, ""))
      end)
      |> transpose()
      |> Enum.reduce("", fn row, acc ->
        case valid?(row) do
          :ok -> acc <> guess_number(row)
          error -> error
        end
      end)
    end)
    |> then(fn
      [{:error, error}] -> {:error, error}
      list -> {:ok, Enum.join(list, ",")}
    end)
  end

  defp transpose([[] | _tail]), do: []
  defp transpose(matrix) do
    firsts = Enum.map(matrix, &(hd(&1)))
    rest = Enum.map(matrix, &(tl(&1)))
    [firsts | transpose(rest)]
  end

  defp valid?(row) do
    cond do
      Enum.count(row) != 4 -> {:error, "invalid line count"}

      Enum.any?(row, &(String.length(&1) != 3)) -> {:error, "invalid column count"}

      true -> :ok
    end
  end

  defp guess_number([" _ ", "| |", "|_|", "   "]), do: "0"
  defp guess_number(["   ", "  |", "  |", "   "]), do: "1"
  defp guess_number([" _ ", " _|", "|_ ", "   "]), do: "2"
  defp guess_number([" _ ", " _|", " _|", "   "]), do: "3"
  defp guess_number(["   ", "|_|", "  |", "   "]), do: "4"
  defp guess_number([" _ ", "|_ ", " _|", "   "]), do: "5"
  defp guess_number([" _ ", "|_ ", "|_|", "   "]), do: "6"
  defp guess_number([" _ ", "  |", "  |", "   "]), do: "7"
  defp guess_number([" _ ", "|_|", "|_|", "   "]), do: "8"
  defp guess_number([" _ ", "|_|", " _|", "   "]), do: "9"
  defp guess_number(_), do: "?"
end


OcrNumbers.convert([" _ ", "| |", "   "])
|> IO.inspect()
