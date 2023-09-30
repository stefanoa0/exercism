defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list

  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head) do
    flatten(head) ++ flatten(tail)
  end
  def flatten([head | tail]) when is_nil(head) do
    [] ++ flatten(tail)
  end
  def flatten([head | tail]) do
    [head] ++ flatten(tail)
  end
end


FlattenArray.flatten([1, [2], 3, nil]) |> IO.inspect()
