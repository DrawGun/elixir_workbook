defmodule EchoServerTest do
  use ExUnit.Case
  doctest EchoServer

  test "проверка ответа на вызов ping" do
    {:ok, pid} = EchoServer.start_link()
    assert {:pong, _node} = GenServer.call(pid, :ping)
  end
end
