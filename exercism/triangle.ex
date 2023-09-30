defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    a
    |> validate_triangle(b, c)
    |> triangle_kind(a, b, c)
  end

  defp validate_triangle(a, b, c) when a <= 0 or b <= 0 or c <= 0 do
    {:error, "all side lengths must be positive"}
  end

  defp validate_triangle(a, b, c) when a + b < c or b + c < a or a + c < b do
    {:error, "side lengths violate triangle inequality"}
  end

  defp validate_triangle(_a, _b, _c), do: {:ok, :triangle}

  defp triangle_kind({:error, error}, _a, _b, _c), do: {:error, error}

  defp triangle_kind({:ok, _}, a, b, c) when a == b and b == c, do: {:ok, :equilateral}
  defp triangle_kind({:ok, _}, a, b, c) when a == b or a == c or b == c, do: {:ok, :isosceles}
  defp triangle_kind({:ok, _}, _a, _b, _c), do: {:ok, :scalene}
end
