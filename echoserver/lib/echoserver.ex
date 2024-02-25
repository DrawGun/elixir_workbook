defmodule EchoServer do
  use GenServer

  @moduledoc """
  Модуль простого эхо сервера.
  """

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call(:ping, {pid, _ref}, state) do
    send(pid, {:pong, node()})
    {:reply, {:pong, node()}, state}
  end
end
