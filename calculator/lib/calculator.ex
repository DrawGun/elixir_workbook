defmodule Calculator do
  @moduledoc """
  Модуль калькулятора, предоставляющий базовые арифметические операции.
  """

  @doc """
  Складывает два числа.

  ## Примеры:

      iex> Calculator.add(2, 3)
      5

  """
  def add(a, b) when is_number(a) and is_number(b) do
    a + b
  end

  @doc """
  Вычитает второе число из первого.

  ## Примеры:

      iex> Calculator.subtract(5, 2)
      3

  """
  def subtract(a, b) when is_number(a) and is_number(b) do
    a - b
  end

  @doc """
  Умножает два числа.

  ## Примеры

      iex> Calculator.multiply(4, 5)
      20

  """
  def multiply(a, b) when is_number(a) and is_number(b) do
    a * b
  end

  @doc """
  Делит первое число на второе.

  ## Примеры

      iex> Calculator.divide(10, 2)
      5.0
      iex> Calculator.divide(10, 0)
      ** (FunctionClauseError) no function clause matching in Calculator.divide/2

  """
  def divide(a, b) when is_number(a) and is_number(b) and b != 0 do
    a / b
  end
end
