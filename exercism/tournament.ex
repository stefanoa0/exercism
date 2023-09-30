defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  defstruct team: nil, mp: nil, w: nil, d: nil, l: nil, p: nil

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.reduce([], &generate_tally_result/2)
    |> Enum.sort_by(&(&1.p))
    |> to_table()
  end

  defp generate_tally_result("", acc), do: acc
  defp generate_tally_result(game, acc) do
    case String.split(game, ";", trim: true) do
      [team1, team2, match] ->
        {team1_result, team2_result} = game_result(team1, team2, match)

        acc
        |> merge_results(team1_result)
        |> merge_results(team2_result)
      _ -> acc
    end
  end

  defp game_result(team1, team2, "win") do
    {
      %__MODULE__{team: team1, mp: 1, w: 1, d: 0, l: 0, p: 3},
      %__MODULE__{team: team2, mp: 1, w: 0, d: 0, l: 1, p: 0}
    }
  end

  defp game_result(team1, team2, "draw") do
    {
      %__MODULE__{team: team1, mp: 1, w: 0, d: 1, l: 0, p: 1},
      %__MODULE__{team: team2, mp: 1, w: 0, d: 1, l: 0, p: 1}
    }
  end

  defp game_result(team1, team2, "loss") do
    {
      %__MODULE__{team: team1, mp: 1, w: 0, d: 0, l: 1, p: 0},
      %__MODULE__{team: team2, mp: 1, w: 1, d: 0, l: 0, p: 3}
    }
  end

  defp game_result(_, _, _) do
    {
      %__MODULE__{},
      %__MODULE__{}
    }
  end

  defp merge_results(list, team_result) do
    case Enum.find(list, fn %{team: val} -> val == team_result.team end) do
      nil -> [team_result | list]
      existing_team_result ->
        new_team_result = merge_tournament_results(existing_team_result, team_result)
        new_list = remove_existing_values(list, existing_team_result)
        [new_team_result | new_list]
    end
  end

  defp merge_tournament_results(team1_existing, team1) do
    Map.merge(team1_existing, team1,
          fn
            :__struct__, v1, _v2 -> v1
            :team, v1, _v2 -> v1
            _k, nil, _v2 -> ""
            _k, _v1, nil -> ""
            _k, v1, v2 -> v1 + v2
        end)
  end

  defp to_table(list) do
    head = "Team                           | MP |  W |  D |  L |  P\n"
    body = Enum.reduce(list, "", fn tournament, acc ->
      row(tournament) <> acc
    end)

    String.trim(head <> body)
  end

  defp row(%{team: nil}), do: ""
  defp row(t) do
    "#{String.pad_trailing(t.team, 31)}|#{formatted(t.mp)} |#{formatted(t.w)} |#{formatted(t.d)} |#{formatted(t.l)} |#{formatted(t.p)}\n"
  end

  defp formatted(num) do
    Integer.to_string(num) |> String.pad_leading(3)
  end

  defp remove_existing_values(list, existing_team_result) do
    Enum.reject(list, fn
      nil -> []
      %{team: val} -> val == existing_team_result.team
    end)
  end
end

[
  "",
  "Allegoric Alaskans@Blithering Badgers;draw",
  "Blithering Badgers;Devastating Donkeys;loss",
  "Devastating Donkeys;Courageous Californians;win;5",
  "Courageous Californians;Allegoric Alaskans;los"
]
|> Tournament.tally()
|> IO.inspect
