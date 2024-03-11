defmodule DepotTest do
  use ExUnit.Case
  doctest Depot

  test "route/0 starts the Tram process" do
    {:ok, pid} = Depot.route()
    assert Process.alive?(pid)
  end
end
