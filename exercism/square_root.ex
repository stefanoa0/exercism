defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(2), do: 2
  def calculate(radicand) do
    1..div(radicand, 2)
    |> Enum.reduce_while(1, fn rad, _ ->
       if radicand == rad * rad, do: {:halt, rad}, else: {:cont, rad}
    end)
  end
end

SquareRoot.calculate(3) |> IO.inspect()
