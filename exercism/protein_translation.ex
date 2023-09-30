defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(""), do: {:ok, []}
  def of_rna(rna) do
    rna
    |> String.split("", trim: true)
    |> Enum.chunk_every(3)
    |> codon_of_rna()
    |> handle_codons()
  end

  defp codon_of_rna(rna_list, actual_codon \\ "", codon_list \\ [])
  defp codon_of_rna(_rna_list, "STOP", codon_list), do: Enum.reject(codon_list, &(&1 == "STOP"))
  defp codon_of_rna([], _actual_codon, codon_list), do: codon_list
  defp codon_of_rna([head | tail], _actual_codon, codon_list) do
    {_status, codon} = head
    |> Enum.join("")
    |> of_codon()

    codon_of_rna(tail, codon, codon_list ++ [codon])
  end

  defp handle_codons(codon_list) do
    if Enum.any?(codon_list, & (&1 == "invalid codon")) do
      {:error, "invalid RNA"}
    else
      {:ok, codon_list}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """

  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case Map.get(@codons, codon) do
      nil -> {:error, "invalid codon"}
      codon_value -> {:ok, codon_value}
    end
  end
end

strand = "AUGUUUUGG"
ProteinTranslation.of_rna(strand)
