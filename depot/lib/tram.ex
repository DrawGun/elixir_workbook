defmodule Tram do
  use GenServer

  @moduledoc """
  Попытка имплементации логики работы трамвая
  """

  defstruct speed: 0, doors: :closed, accident: false

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_init_arg) do
    {:ok, %{state: :stop, tram: %Tram{}}}
  end

  def get_state(tram_pid) do
    GenServer.call(tram_pid, :get_state)
  end

  def move(tram_pid) do
    GenServer.call(tram_pid, %{state: :move})
  end

  def stop(tram_pid) do
    GenServer.call(tram_pid, %{state: :stop})
  end

  def open_doors(tram_pid) do
    GenServer.call(tram_pid, %{state: :open_doors})
  end

  def close_doors(tram_pid) do
    GenServer.call(tram_pid, %{state: :close_doors})
  end

  def accident(tram_pid) do
    GenServer.call(tram_pid, %{state: :accident})
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(%{state: :move}, _from, %{state: state, tram: tram} = args) do
    case state do
      :stop -> {:reply, :movement, %{state: :movement, tram: %{tram | speed: 10}}}
      :movement -> {:reply, state, args}
      _ -> {:reply, "Движение невозможно", args}
    end
  end

  def handle_call(%{state: :stop}, _from, %{state: state, tram: tram} = args) do
    case state do
      :movement -> {:reply, :stop, %{state: :stop, tram: %{tram | speed: 0}}}
      :stop -> {:reply, state, args}
      :doors_are_opened -> {:reply, state, args}
      :accident -> {:reply, :accident, %{state: :stop, tram: %{tram | speed: 0}}}
    end
  end

  def handle_call(%{state: :open_doors}, _from, %{state: state, tram: tram} = args) do
    case state do
      :stop -> {:reply, :doors_are_opened, %{state: :doors_are_opened, tram: %{tram | doors: :opened}}}
      :doors_are_opened -> {:reply, state, args}
      :accident -> {:reply, :doors_are_opened, %{state: :doors_are_opened, tram: %{tram | doors: :opened}}}
      _ -> {:reply, "Нельзя открыть двери", args}
    end
  end

  def handle_call(%{state: :close_doors}, _from, %{state: state, tram: tram} = args) do
    case state do
      :doors_are_opened -> {:reply, :doors_are_closed, %{state: :doors_are_closed, tram: %{tram | doors: :closed}}}
      _ -> {:reply, "Двери могут быть закрытыми только при открытых дверях.", args}
    end
  end

  def handle_call(%{state: :accident}, _from, %{state: state, tram: tram} = _args) do
    case state do
      _ -> {:reply, :accident, %{state: :accident, tram: %{tram | doors: :opened, speed: 0}}}
    end
  end
end
