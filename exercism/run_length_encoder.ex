defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @numbers ~w(1 2 3 4 5 6 7 8 9 0)

  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""
  def encode(string) do
    string
    |> String.split("", trim: true)
    |> do_encode()
    |> Enum.reduce("", fn
      {char, 1}, acc -> acc <> char
      {char, size}, acc -> acc <> "#{size}#{char}"
    end)
  end

  defp do_encode(list_of_chars, actual_tuple \\ nil, list \\ [])
  defp do_encode([], acc, list), do: list ++ [acc]

  defp do_encode([head | tail], nil, list) do
    do_encode(tail, {head, 1}, list)
  end

  defp do_encode([head | tail], {char, acc}, list) when head == char do
    do_encode(tail, {char, acc + 1}, list)
  end

  defp do_encode([head | tail], {char, acc}, list) do
    do_encode(tail, {head, 1}, list ++ [{char, acc}])
  end

  @spec decode(String.t()) :: String.t()
  def decode(""), do: ""
  def decode(string) do
    string
    |> String.split("", trim: true)
    |> do_decode()
  end

  defp do_decode(list, actual_char \\ "", acc \\ "")
  defp do_decode([], _char, acc), do: acc
  defp do_decode([head | tail], actual_char, acc) when head in @numbers do
    do_decode(tail, actual_char <> to_string(head), acc)
  end

  defp do_decode([head | tail], "", acc) do
    do_decode(tail, "", acc <> head)
  end

  defp do_decode([head | tail], char, acc) do
    size = String.to_integer(char)
    do_decode(tail, "", acc <> String.duplicate(head, size))
  end
end

RunLengthEncoder.decode("2 hs2q q2w2 ") |> IO.inspect()
