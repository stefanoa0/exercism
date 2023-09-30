defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @open_brackets ["[", "(", "{"]
  @close_brackets ["]", ")", "}"]

  @match_brackets %{"}" => "{", ")" => "(", "]" => "["}

  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.split("", trim: true)
    |> do_check()
  end

  defp do_check(list, acc \\ [], balanced \\ true)
  defp do_check(_list, _acc, false), do: false
  defp do_check([], acc, balanced) do
    Enum.empty?(acc) and balanced
  end

  defp do_check([head | tail], acc, balanced) when head in @open_brackets do
    do_check(tail, [head | acc] , balanced)
  end

  defp do_check([head | tail], acc, balanced) when head in @close_brackets do
    {balanced, acc} = if brackets_match?(head, acc) do
      {_, acc} = List.pop_at(acc, 0)
      {balanced, acc}
    else
      {false, acc}
    end

    do_check(tail, acc, balanced)
  end

  defp do_check([_head | tail], acc, balanced) do
    do_check(tail, acc, balanced)
  end

  defp brackets_match?(_closed_bracket, []), do: false
  defp brackets_match?(closed_bracket, [head | _tail]) do
    @match_brackets[closed_bracket] == head
  end
end

MatchingBrackets.check_brackets("}{") |> IO.inspect()
