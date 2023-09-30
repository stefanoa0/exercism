defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    div(score, 2) - 5
  end

  @spec ability :: pos_integer()
  def ability do
    dices = 1..4
    |> Enum.map(fn _ ->
      Enum.random([1, 2, 3, 4, 5, 6])
    end)

    dices
    |> Enum.sort()
    |> Enum.drop(1)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    constituition = ability()
    %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: constituition,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: 10 + modifier(constituition)
    }
  end
end

Enum.each(1..20, fn _ -> DndCharacter.ability() in 3..18 end)
|> IO.inspect()
