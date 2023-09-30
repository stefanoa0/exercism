defmodule WineCellar do
  def explain_colors do
    [
    white: "Fermented without skin contact.",
    red: "Fermented with skin contact using dark-colored grapes.",
    rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []) do
    list = filter_by_color(cellar, color)

    filter_by_year(list, Keyword.get(opts, :year))
    filter_by_country(list, Keyword.get(opts, :country))
  end

  defp filter_by_color([], color), do: []
  defp filter_by_color([{wine_color, desc} | tail], color) when color == wine_color do
    [desc | filter_by_color(tail, color)]
  end
  defp filter_by_color([_head | tail], color) do
    filter_by_color(tail, color)
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []
  defp filter_by_year(wines, nil), do: wines
  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []
  defp filter_by_country(wines, nil), do: wines
  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end

cellar = [
  white: {"Chardonnay", 2015, "Italy"},
  white: {"Chardonnay", 2014, "France"},
  rose: {"Dornfelder", 2018, "Germany"},
  red: {"Merlot", 2015, "France"},
  white: {"Riesling ", 2017, "Germany"},
  white: {"Pinot grigio", 2015, "Germany"},
  red: {"Pinot noir", 2016, "France"},
  red: {"Pinot noir", 2013, "Italy"}
]

WineCellar.filter(cellar, :white)
