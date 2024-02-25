defmodule EchoServerTest do
  use ExUnit.Case
  doctest EchoServer

  test "проверка ответа на вызов ping" do
    {:ok, pid} = EchoServer.start_link()
    assert {:pong, node} = GenServer.call(pid, :ping)
    assert_receive {:pong, ^node}
  end
end
