defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r/\s|-|_/, trim: true)
    |> Enum.reduce("", fn word, acc ->
      abbr = word
        |> String.first()
        |> String.upcase()

      acc <> abbr
    end)
    |> dbg()
  end
end
