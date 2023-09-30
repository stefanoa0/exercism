defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: tree_data, left: nil} = bst_node, data) when data <= tree_data do
    Map.put(bst_node, :left, new(data))
  end

  def insert(%{data: tree_data, left: left} = bst_node, data) when data <= tree_data do
    Map.put(bst_node, :left, insert(left, data))
  end

  def insert(%{right: nil} = bst_node, data) do
    Map.put(bst_node, :right, new(data))
  end

  def insert(%{right: right} = bst_node, data) do
    Map.put(bst_node, :right, insert(right, data))
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    do_in_order(tree, [])
  end

  defp do_in_order(nil, list), do: list

  defp do_in_order(tree, list) do
    list = do_in_order(tree.left, list)

    list = list ++ [tree.data]

    do_in_order(tree.right, list)
  end
end


BinarySearchTree.new(4)
|> BinarySearchTree.insert(2)
|> BinarySearchTree.insert(6)
|> BinarySearchTree.insert(1)
|> BinarySearchTree.insert(3)
|> BinarySearchTree.insert(5)
|> BinarySearchTree.insert(7)
|> BinarySearchTree.in_order()
|> dbg()
