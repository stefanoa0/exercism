defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    if Enum.count(strand1) != Enum.count(strand2) do
      {:error, "strands must be of equal length"}
    else
      diff = strand1
      |> Enum.with_index()
      |> Enum.reduce(0, fn {char, index}, acc ->
        if char != Enum.at(strand2, index), do: acc + 1, else: acc
      end)
      {:ok, diff}
    end
  end
end

Hamming.hamming_distance(~c"GGACGGATTCTG", ~c"AGGACGGATTCT")
|> IO.inspect()
