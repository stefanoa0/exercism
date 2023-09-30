defmodule DateParser do
  def day() do
    "(0?[1-9])$|([1-2][0-9])$|([3][0-1])"
  end

  def month() do
    "[0][1-9]$|^[1][0-2]$|^[1-9]$"
  end

  def year() do
    "[1-9][0-9][0-9][0-9]"
  end

  def day_names() do
    "(^[t|T]uesday|hursday)$|(^[s|S]aturday|unday)$|(^[m|M](onday))$|(^[w|W](ednesday))$|(^[f|F](riday))$"
  end

  def month_names() do
    "^[j|J](anuary|une|uly)$|^[f|F](ebruary)$|^[m|M](arch|ay)$|^[a|A](pril|ugust)$|(^[s|S](eptember))$|(^[o|O]ctober)$|(^[n|N]ovember)$|(^[d|D]ecember)$"
  end

  def capture_day() do
    "(?<day>#{day()})"
  end

  def capture_month() do
    "(?<month>#{month()})"
  end

  def capture_year() do
    "(?<year>#{year()})"
  end

  def capture_day_name() do
    "(?<day_name>#{day_names()})"
  end

  def capture_month_name() do
    "(?<month_name>#{month_names()})"
  end

  def capture_numeric_date() do
   "#{capture_day()}/#{capture_month()}/#{capture_year()}"
  end

  def capture_month_name_date() do
    "#{capture_month_name()}\\s#{capture_day()},\\s#{capture_year()}"
  end

  def capture_day_month_name_date() do
    "#{capture_day_name()},\\s#{capture_month_name()}\\s#{capture_day()},\\s#{capture_year()}"
  end

  def match_numeric_date() do
    Regex.compile!("^#{capture_numeric_date()}$")
  end

  def match_month_name_date() do
    Regex.compile!("^#{capture_month_name_date()}$")
  end

  def match_day_month_name_date() do
    Regex.compile!("^#{capture_day_month_name_date()}$")
  end
end

DateParser.capture_numeric_date() |> Regex.compile!() |> IO.inspect()
