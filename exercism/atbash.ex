defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.replace(~r/[ ,.]/, "")
    |> to_charlist()
    |> Enum.chunk_every(5)
    |> Enum.map(fn list ->
      Enum.map(list, fn
        char when char in ~c'1234567890' -> char
        ?, -> ''
        ?\s -> ''
        char -> char + (-2 * char + 219)
      end)
    end)
    |> Enum.join(" ")
    |> to_string()
    |> dbg()
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.split(" ", trim: true)
    |> Enum.map(fn word ->
      to_charlist(word)
      |> Enum.map(fn
        char when char in ~c'1234567890' -> char
        char -> char + (-2 * char + 219)
      end)
      |> to_string()
    end)
    |> Enum.join("")
  end
end

Atbash.encode("Testing, 1 2 3, testing.")
