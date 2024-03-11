defmodule Depot do
  @moduledoc """
  Модуль для запуска Tram.
  """

  def route do
    Tram.start_link()
  end
end
