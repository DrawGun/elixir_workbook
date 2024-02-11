defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator

  test "addition" do
    assert Calculator.add(2, 3) == 5
  end

  test "subtraction" do
    assert Calculator.subtract(5, 2) == 3
  end

  test "multiplication" do
    assert Calculator.multiply(4, 5) == 20
  end

  test "division" do
    assert Calculator.divide(10, 2) == 5.0
  end
end
