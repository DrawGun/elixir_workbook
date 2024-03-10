defmodule TramTest do
  use ExUnit.Case
  doctest Tram

  test "get_state returns initial state" do
    {:ok, pid} = Tram.start_link()
    assert %{state: :stop, tram: %Tram{}} = Tram.get_state(pid)
  end

  test "move changes state from stop to movement" do
    {:ok, pid} = Tram.start_link()
    assert :movement = Tram.move(pid)
  end

  test "move does not change state from movement" do
    {:ok, pid} = Tram.start_link()
    assert :movement = Tram.move(pid)
    assert :movement = Tram.move(pid)
  end

  test "move returns error message if state is not stop or movement" do
    {:ok, pid} = Tram.start_link()
    assert :doors_are_opened = Tram.open_doors(pid)
    assert "Движение невозможно" = Tram.move(pid)
  end

  test "stop changes state from movement to stop" do
    {:ok, pid} = Tram.start_link()
    assert :movement = Tram.move(pid)
    assert :stop = Tram.stop(pid)
  end

  test "stop does not change state from stop" do
    {:ok, pid} = Tram.start_link()
    assert :stop = Tram.stop(pid)
    assert :stop = Tram.stop(pid)
  end

  test "stop does not change state from doors_are_opened" do
    {:ok, pid} = Tram.start_link()
    assert :doors_are_opened = Tram.open_doors(pid)
    assert :doors_are_opened = Tram.stop(pid)
  end

  test "stop does not change state from accident" do
    {:ok, pid} = Tram.start_link()
    assert :accident = Tram.accident(pid)
    assert :accident = Tram.stop(pid)
  end

  test "open_doors changes state from stop to doors_are_opened" do
    {:ok, pid} = Tram.start_link()
    assert :doors_are_opened = Tram.open_doors(pid)
  end

  test "open_doors does not change state from doors_are_opened" do
    {:ok, pid} = Tram.start_link()
    assert :doors_are_opened = Tram.open_doors(pid)
    assert :doors_are_opened = Tram.open_doors(pid)
  end

  test "open_doors does not change state from accident" do
    {:ok, pid} = Tram.start_link()
    assert :accident = Tram.accident(pid)
    assert :doors_are_opened = Tram.open_doors(pid)
  end

  test "close_doors changes state from doors_are_opened to stop" do
    {:ok, pid} = Tram.start_link()
    assert :doors_are_opened = Tram.open_doors(pid)
    assert :doors_are_closed = Tram.close_doors(pid)
  end

  test "close_doors does not change state" do
    {:ok, pid} = Tram.start_link()
    assert "Двери могут быть закрытыми только при открытых дверях." = Tram.close_doors(pid)
    assert "Двери могут быть закрытыми только при открытых дверях." = Tram.close_doors(pid)
  end

  test "close_doors does not change state from accident" do
    {:ok, pid} = Tram.start_link()
    assert :accident = Tram.accident(pid)
    assert "Двери могут быть закрытыми только при открытых дверях." = Tram.close_doors(pid)
  end

  test "accident changes state to accident" do
    {:ok, pid} = Tram.start_link()
    assert :accident = Tram.accident(pid)
  end
end
