defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    limit = limit - 1
    factors
    |> Enum.map(fn factor ->
        factor..limit\\factor
        |> Enum.to_list()
    end)
    |> Enum.reduce(MapSet.new(), fn multiples, acc ->
      multiples
      |> MapSet.new()
      |> MapSet.union(acc)
    end)
  end
end
