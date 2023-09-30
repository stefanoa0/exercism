defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence_list = sentence
    |> String.downcase()
    |> String.split("", trim: true)

    sentence_list
    |> Enum.any?(fn
      " " -> false
      "-" -> false
      char -> Enum.count(sentence_list, &(&1 == char)) > 1
    end)
    |> Kernel.!()
  end
end

Isogram.isogram?("isogram") |> IO.inspect()
