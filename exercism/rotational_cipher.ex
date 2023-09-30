defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @d_alphabet ~c(abcdefghijklmnopqrstuvwxyz)
  @u_alphabet ~c(ABCDEFGHIJKLMNOPQRSTUVWXYZ)

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(fn
      char when char in @d_alphabet ->
        convert_char(char, shift, ?z) |> IO.inspect()

      char when char in @u_alphabet ->
        convert_char(char, shift, ?Z)

      char -> char
      end)
      |> to_string()
  end

  def convert_char(char, shift, max) do
    new_char = char + shift
    if new_char > max, do: new_char - 26, else: new_char
  end
end

plaintext = "Testing 1 2 3 testing"
shift = 4
RotationalCipher.rotate(plaintext, shift) |> IO.inspect()
