defmodule EchoServer do
  use GenServer

  @moduledoc """
  Модуль простого эхо сервера.
  """

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call(:ping, _from, state) do
    {:reply, {:pong, node()}, state}
  end
end
