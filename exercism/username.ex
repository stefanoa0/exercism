defmodule Username do

  def sanitize([]), do: []
  def sanitize([head | tail]) do
    head = case head do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      ?_ -> '_'
      '1' -> ''
      '2' -> ''
      '3' -> ''
      '4' -> ''
      '5' -> ''
      '6' -> ''
      '7' -> ''
      '8' -> ''
      '9' -> ''
      '$' -> ''
      _ -> head
    end
    [head] ++ sanitize(tail)
  end
end


Username.sanitize([107, 114, 252, 103, 101, 114]) |> IO.inspect()
