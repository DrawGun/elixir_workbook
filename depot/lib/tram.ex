defmodule Tram do
  use GenServer

  @moduledoc """
  Логика работы трамвая
  """

  defstruct speed: 0, doors: :closed, accident: false, state: :stop

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_init_arg) do
    {:ok, %Tram{}}
  end

  def get_state(tram_pid) do
    GenServer.call(tram_pid, :get_state)
  end

  def move(tram_pid) do
    GenServer.call(tram_pid, :move)
  end

  def stop(tram_pid) do
    GenServer.call(tram_pid, :stop)
  end

  def open_doors(tram_pid) do
    GenServer.call(tram_pid, :open_doors)
  end

  def close_doors(tram_pid) do
    GenServer.call(tram_pid, :close_doors)
  end

  def accident(tram_pid) do
    GenServer.call(tram_pid, :accident)
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:move, _from, %Tram{state: :stop} = tram),
    do: {:reply, :movement, %Tram{tram | state: :movement, speed: 10}}

  def handle_call(:move, _from, %Tram{state: :movement} = tram),
    do: {:reply, :movement, tram}

  def handle_call(:move, _from, %Tram{state: state} = tram),
    do: {:reply, "Движение в состоянии #{state} невозможно", tram}

  def handle_call(:stop, _from, %Tram{state: :movement} = tram),
    do: {:reply, :stop, %Tram{tram | state: :stop, speed: 0}}

  def handle_call(:stop, _from, %Tram{state: :accident} = tram),
    do: {:reply, :accident, %Tram{tram | state: :stop, speed: 0}}

  def handle_call(:stop, _from, %Tram{state: _state} = tram),
    do: {:reply, :stop, %Tram{tram | state: :stop}}

  def handle_call(:open_doors, _from, %Tram{state: :stop} = tram),
    do: {:reply, :doors_are_opened, %Tram{tram | state: :doors_are_opened, doors: :opened}}

  def handle_call(:open_doors, _from, %Tram{state: :accident} = tram),
    do: {:reply, :doors_are_opened, %Tram{tram | state: :doors_are_opened, doors: :opened}}

  def handle_call(:open_doors, _from, %Tram{state: :doors_are_opened} = tram),
    do: {:reply, :doors_are_opened, tram}

  def handle_call(:open_doors, _from, %Tram{state: state} = tram),
    do: {:reply, "Нельзя в состоянии #{state} открыть двери", tram}

  def handle_call(:close_doors, _from, %Tram{state: :doors_are_opened} = tram),
    do: {:reply, :doors_are_closed, %Tram{tram | state: :doors_are_closed, doors: :closed}}

  def handle_call(:close_doors, _from, %Tram{state: _state} = tram),
    do: {:reply, "Двери могут быть закрытыми только при открытых дверях.", tram}

  def handle_call(:accident, _from, %Tram{state: _state} = tram),
    do: {:reply, :accident, %Tram{tram | state: :accident, doors: :opened, speed: 0}}
end
