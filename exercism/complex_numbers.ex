defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  import Integer, only: [pow: 2]

  @type complex :: {float, float}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real({a, _i}) do
    a
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary({_a, i}) do
    i
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | float, b :: complex | float) :: complex
  def mul({a, b}, {c, d}) do
    {(a * c - b * d), (b * c + a * d)}
  end

  def mul(a, {c, d}) do
    mul({a, 0}, {c, d})
  end

  def mul({a, b}, c) do
    mul({a, b}, {c, 0})
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | float, b :: complex | float) :: complex
  def add({a, b}, {c, d}) do
    {(a + c), (b + d)}
  end

  def add(a, {c, d}) do
    add({a, 0}, {c, d})
  end

  def add({a, b}, c) do
    add({a, b}, {c, 0})
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | float, b :: complex | float) :: complex
  def sub({a, b}, {c, d}) do
    {(a - c), (b - d)}
  end

  def sub(a, {c, d}) do
    sub({a, 0}, {c, d})
  end

  def sub({a, b}, c) do
    sub({a, b}, {c, 0})
  end


  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | float, b :: complex | float) :: complex
  def div({a, b}, {c, d}) do
    {((a * c) + (b * d)) / (pow(c, 2) + pow(d, 2)), ((b * c) - (a * d)) / (pow(c, 2) + pow(d, 2))}
  end

  def div({a, b}, c) do
    __MODULE__.div({a, b}, {c, 0})
  end

  def div(a, {c, d}) do
    __MODULE__.div({a, 0}, {c, d})
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs({a, i}) do
    a
    |> pow(2)
    |> Kernel.+(pow(i, 2))
    |> Kernel./(1)
    |> Float.pow(0.5)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({a, i}) do
    {a, i * -1}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({a, b}) do
    {:math.exp(a) * :math.cos(b), :math.exp(a) * :math.sin(b)}
  end
end
