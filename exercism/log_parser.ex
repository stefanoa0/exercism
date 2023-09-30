defmodule LogParser do
  def valid_line?(line) do
    String.match?(line, ~r/^\[(ERROR|DEBUG|INFO|WARNING|)\].*$/)
  end

  def split_line(line) do
    String.split(line, ~r/<[*~=-]*>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/((e|E)(n|N)(d|D))-((o|O)(f|F))-((l|L)(i|I)(n|N)(e|E))[0-9]+/, "")
  end

  def tag_with_user_name(line) do
    case Regex.named_captures(~r/(u|U)(s|S)(e|E)(r|R)\s*(?<name>\S*)/, line) do
      %{"name" => name} -> "[USER] name " <> line
      _ -> line
    end
  end
end

LogParser.tag_with_user_name("[DEBUG] Created User\nAlice908101\nat 14:02")
