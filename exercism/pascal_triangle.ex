defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    1..num
    |> Enum.map(fn n ->
      row(n)
    end)
  end

  defp row(1), do: [1]
  defp row(n) do
    row(1) ++ sum_each_pair(row(n - 1))
  end

  def sum_each_pair(list, previous \\ 0, acc \\ [])
  def sum_each_pair([], _previous, acc), do: acc
  def sum_each_pair([head | tail], previous, acc) do
    sum_of_pair = head + previous
    sum_each_pair(tail, head, [sum_of_pair | acc])
  end
end


PascalsTriangle.rows(20) |> IO.inspect()
