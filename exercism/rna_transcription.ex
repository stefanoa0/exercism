defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna,
      fn ?A -> ?U
         ?C -> ?T
         ?T -> ?A
         ?G -> ?C
    end)
  end
end

RnaTranscription.to_rna(~c"ACGTGGTCTTAA")
|> IO.inspect()
