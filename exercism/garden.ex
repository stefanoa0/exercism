defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @student_names [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @plants %{
    "V" => :violets,
    "R" => :radishes,
    "C" => :clover,
    "G" => :grass
  }

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @student_names) do
    plants = plant_string_to_list_of_plants(info_string)

    student_names
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.reduce([], fn {student, index}, acc ->
      student_plant = map_students_index(plants, index) |> Enum.map(& @plants[&1]) |> List.to_tuple()
      acc ++ [{student, student_plant}]
    end)
    |> Enum.into(%{})
  end

  defp plant_string_to_list_of_plants(info_string) do
    info_string
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(&Enum.chunk_every(&1, 2))
  end

  defp map_students_index(plant_list, index) do
    Enum.reduce(plant_list, [], fn plants, acc ->
      case Enum.fetch(plants, index) do
        {:ok, plant_tuple} -> acc ++ plant_tuple
        _ -> acc
      end
    end)
  end
end
