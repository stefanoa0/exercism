defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    Enum.reduce(keys, data, fn elem, acc -> acc[elem] end)
  end

  def get_in_path(data, path) do
    keys = String.split(path, ".")
    pop_in(data, keys)
  end
end

team_data = %{
  "coach" => %{"first_name" => "Jane", "last_name" => "Brown"},
  "team_name" => "Hoop Masters",
  "players" => %{}
}

BasketballWebsite.extract_from_path(team_data, "coach.first_name")
|> IO.inspect()
