defmodule Username do

  def sanitize([]), do: []
  def sanitize([head | tail]) do
    IO.inspect(head)
    head = case head do
      ?ä -> [97, 101]
      ?ö -> [111, 101]
      ?ü -> [117, 101]
      ?ß -> [115, 115]
      ?_ -> 95
      ?0 -> ''
      ?1 -> ''
      ?2 -> ''
      ?3 -> ''
      ?4 -> ''
      ?5 -> ''
      ?6 -> ''
      ?7 -> ''
      ?8 -> ''
      ?9 -> ''
      ?$ -> ''
      _ -> head
    end
    [head] ++ sanitize(tail)
  end
end
