defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    stream = Task.async_stream(texts, &strings_frequency/1, max_concurrency: workers)

    stream
    |> Enum.to_list()
    |> Enum.reduce(%{}, fn {_ok, string}, acc ->
      Map.merge(acc, string, fn _key, val1, val2 -> val1 + val2 end)
    end)
  end

  defp strings_frequency(string) do
    list_of_chars = string
    |> String.downcase()
    |> String.replace(~r/[\d, ]/, "")
    |> String.split("", trim: true)

    Enum.reduce(list_of_chars, %{}, fn char, acc ->
      Map.put(acc, char, char_frequency(char, list_of_chars))
    end)
  end

  defp char_frequency(char, list, acc \\ 0)
  defp char_frequency(_char, [], acc), do: acc

  defp char_frequency(head, [head | tail], acc) do
    char_frequency(head, tail, acc + 1)
  end

  defp char_frequency(char, [_head | tail], acc) do
    char_frequency(char, tail, acc)
  end
end

Frequency.frequency(List.duplicate("  ", 10000), 4) |> Enum.sort() |> Enum.into(%{}) |> IO.inspect()
