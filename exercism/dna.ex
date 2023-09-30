defmodule DNA do
  @moduledoc false
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      _ -> 0
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      _ -> ?\s
    end
  end

  def encode(dna) do
    dna
    |> _encode()
  end

  def _encode([]), do: []
  def _encode([head | tail]) do
    [encode_nucleotide(head)] ++ _encode(tail)
  end

  def decode(dna) do
    _decode(dna)
  end

  def _decode([]), do: []
  def _decode([head | tail]) do
    [decode_nucleotide(head)] ++ _decode(tail)
  end
end
