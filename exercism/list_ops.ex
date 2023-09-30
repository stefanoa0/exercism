defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l
    |> do_map(f)
    |> do_reverse()
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l
    |> do_filter(f)
    |> do_reverse()
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, f) do
    do_foldl(l, acc, f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
    l
    |> do_reverse()
    |> do_foldl(acc, f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a
    |> do_reverse()
    |> do_append(b)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    ll
    |> do_concat()
    |> do_reverse()
  end

  defp do_count(l, acc \\ 0)
  defp do_count([], acc), do: acc
  defp do_count([_head | tail], acc), do: do_count(tail, acc + 1)

  defp do_reverse(l, new_list \\ [])
  defp do_reverse([], new_list), do: new_list
  defp do_reverse([head | tail], new_list), do: do_reverse(tail, [head | new_list])

  defp do_map(l, fun, new_list \\ [])
  defp do_map([], _fun, new_list), do: new_list
  defp do_map([head | tail], fun, new_list) do
    new_list = [fun.(head) | new_list]
    do_map(tail, fun, new_list)
  end

  defp do_filter(l, fun, new_list \\ [])
  defp do_filter([], _fun, new_list), do: new_list
  defp do_filter([head | tail], fun, new_list) do
    if fun.(head), do: do_filter(tail, fun, [head | new_list]), else: do_filter(tail, fun, new_list)
  end

  defp do_foldl([], acc, _fun), do: acc
  defp do_foldl([head | tail], acc, fun) do
    acc = fun.(head, acc)
    do_foldl(tail, acc, fun)
  end

  defp do_append([], list), do: list
  defp do_append([head | tail], list) do
    do_append(tail, [head | list])
  end

  defp do_concat(list, new_list \\ [])
  defp do_concat([], new_list), do: new_list
  defp do_concat([head | tail], new_list) do
    new_list = do_append(head, new_list)
    do_concat(tail, new_list)
  end
end
