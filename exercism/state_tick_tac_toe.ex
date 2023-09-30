defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    board
    |> String.split(~r/[\n\r]/, trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> check_matrix()
  end

  defp check_matrix(matrix) do
    cond do
      non_valid_matrix?(matrix) ->
        {:error, "Impossible board: game should have ended after the game was won"}

      illegal_positions?(matrix, :x) ->
        {:error, "Wrong turn order: X went twice"}

      illegal_positions?(matrix, :o) ->
        {:error, "Wrong turn order: O started"}

      row_win?(matrix) ->
        {:ok, :win}

      col_win?(matrix) ->
        {:ok, :win}

      diagonal_win?(matrix) ->
        {:ok, :win}

      contra_diagonal_win?(matrix) ->
        {:ok, :win}

      ongoing?(matrix) ->
        {:ok, :ongoing}

      true ->
        {:ok, :draw}
    end
  end

  defp row_win?(matrix) do
    Enum.any?(matrix, &check_row/1)
  end

  defp col_win?(matrix) do
    matrix
    |> transpose()
    |> row_win?()
  end

  defp diagonal_win?(matrix) do
    0..2
    |> Enum.map(fn col -> Enum.at(matrix, col) |> Enum.at(col) end)
    |> check_row()
  end

  defp contra_diagonal_win?(matrix) do
    matrix
    |> Enum.reverse()
    |> diagonal_win?()
  end

  defp check_row(row, current \\ nil, acc \\ true)
  defp check_row(_row, _current, false), do: false
  defp check_row([], _current, acc), do: acc
  defp check_row(["." | _tail] = _row, _current, _acc), do: false
  defp check_row([head | tail] = _row, nil, acc), do: check_row(tail, head, acc)
  defp check_row([head | tail] = _row, head, _acc) do
    check_row(tail, head, true)
  end
  defp check_row([head | tail], _current, _acc) do
    check_row(tail, head, false)
  end

  defp transpose([[] | _tail]), do: []
  defp transpose(matrix) do
    firsts = Enum.map(matrix, &hd/1)
    rest = Enum.map(matrix, &tl/1)
    [firsts | transpose(rest)]
  end

  defp ongoing?(matrix) do
    Enum.any?(matrix, fn row -> Enum.any?(row, & &1 == ".") end)
  end

  defp non_valid_matrix?(matrix) do
    matrix
    |> Enum.map(&check_row/1)
    |> Enum.count(fn result -> result == true end)
    |> Kernel.>(1)
  end

  defp illegal_positions?(matrix, :x) do
    matrix
    |> count_pieces()
    |> then(fn
      %{x: x, o: o} when x > 1 and o == 0 -> true
      _ -> false
    end)
  end

  defp illegal_positions?(matrix, :o) do
    matrix
    |> count_pieces()
    |> then(fn
      %{x: x, o: o} when o >= (x * 2) -> true
      _ -> false
    end)
  end

  defp count_pieces(matrix) do
    matrix
    |> Enum.reduce(%{}, fn row, acc ->
      %{}
      |> Map.put(:x, Enum.count(row, & &1 == "X"))
      |> Map.put(:o, Enum.count(row, & &1 == "O"))
      |> Map.merge(acc, fn _key, val1, val2 -> val1 + val2 end)
    end)
  end
end
