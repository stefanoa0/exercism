defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice) do
    do_score(category, dice)
  end

  defp do_score(:ones, dices) do
    do_score_categories(dices, 1)
  end

  defp do_score(:twos, dices) do
    do_score_categories(dices, 2)
  end

  defp do_score(:threes, dices) do
    do_score_categories(dices, 3)
  end

  defp do_score(:fours, dices) do
    do_score_categories(dices, 4)
  end

  defp do_score(:fives, dices) do
    do_score_categories(dices, 5)
  end

  defp do_score(:sixes, dices) do
    do_score_categories(dices, 6)
  end

  defp do_score(:full_house, dices) do
    dices
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort()
    |> Kernel.==([2, 3])
    |> then(fn
        true -> Enum.sum(dices)
        false -> 0
      end)
  end

  defp do_score(:four_of_a_kind, dices) do
    dices
    |> Enum.frequencies()
    |> Enum.find(fn {_num, freq} -> freq >= 4 end)
    |> then(fn
      {num, _freq} -> 4 * num
      _ -> 0
    end)
  end

  defp do_score(:little_straight, dices) do
    do_score_straight(dices, 1..5)
  end

  defp do_score(:big_straight, dices) do
    do_score_straight(dices, 2..6)
  end

  defp do_score(:choice, dices) do
    Enum.sum(dices)
  end

  defp do_score(:yacht, dices) do
    dices
    |> Enum.frequencies()
    |> Enum.find(fn {_num, freq} -> freq == 5 end)
    |> then(fn
      {_num, _freq} -> 50
      _ -> 0
    end)
  end

  defp do_score_categories(dices, num) do
    dices
    |> Enum.reject(& &1 != num)
    |> Enum.count()
    |> Kernel.*(num)
  end

  defp do_score_straight(dices, seq) do
    dices
    |> Enum.sort()
    |> Kernel.==(Enum.to_list(seq))
    |> then(fn
      true -> 30
      false -> 0
    end)
  end
end
