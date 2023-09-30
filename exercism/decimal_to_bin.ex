defmodule SecretHandshake do
  import Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    commands =
      [8, 4, 2, 1]
      |> Enum.map(&command(code, &1))
      |> IO.inspect()
      |> Enum.reject(&(&1 == ""))

    if (code &&& 16) != 0 do
      Enum.reverse(commands)
    else
      commands
    end
  end

  def command(number, binary) do
    cond do
      binary == 1 && (number &&& binary) != 0 -> "wink"
      binary == 2 && (number &&& binary) != 0 -> "double blink"
      binary == 4 && (number &&& binary) != 0 -> "close your eyes"
      binary == 8 && (number &&& binary) != 0 -> "jump"
      true -> ""
    end
  end
end
