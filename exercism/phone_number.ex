defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    raw
    |> String.replace(~r/[() -.]/, "")
    |> validate()
  end

  defp validate(number) do
    cond do
      not_contains_only_numbers?(number) ->
        {:error, "must contain digits only"}

      less_than_ten_digits?(number) ->
        {:error, "must not be fewer than 10 digits"}

      greater_than_eleven_digits?(number) ->
        {:error, "must not be greater than 11 digits"}

      with_eleven_digits_and_not_start_with_one?(number) ->
        {:error, "11 digits must start with 1"}

      area_code_starts_with_num?(number, "0") ->
        {:error, "area code cannot start with zero"}

      area_code_starts_with_num?(number, "1") ->
        {:error, "area code cannot start with one"}

      exchange_code_starts_with_num?(number, "0") ->
        {:error, "exchange code cannot start with zero"}

      exchange_code_starts_with_num?(number, "1") ->
        {:error, "exchange code cannot start with one"}

      true ->
        {:ok, maybe_clean_country_code(number)}
    end
  end

  defp less_than_ten_digits?(number) do
    String.length(number) < 10
  end

  defp greater_than_eleven_digits?(number) do
    String.length(number) > 11
  end

  defp with_eleven_digits_and_not_start_with_one?(number) do
    Regex.match?(~r/[^1]\d{10}/, number)
  end

  defp with_eleven_digits_and_start_with_one?(number) do
    Regex.match?(~r/^[1]\d{10}/, number)
  end

  defp not_contains_only_numbers?(number) do
    Regex.match?(~r/[\D]/, number)
  end

  defp area_code_starts_with_num?(number, num) do
    number
    |> maybe_clean_country_code()
    |> String.match?(~r/^#{num}/)
  end

  defp exchange_code_starts_with_num?(number, num) do
    number
    |> maybe_clean_country_code()
    |> String.match?(~r/^\d{3}(#{num})[\d]*/)
  end

  defp maybe_clean_country_code(number) do
    if with_eleven_digits_and_start_with_one?(number) do
      String.replace(number, ~r/^1/, "")
    else
      number
    end
  end
end
