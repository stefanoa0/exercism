defmodule TakeANumber do
  def start() do
    spawn(fn -> load(0) end)
  end

  def load(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        load(state)
      {:take_a_number, sender_pid} ->
        new_state = state + 1
        send(sender_pid, new_state)
        load(new_state)
      :stop -> nil
      _ ->  load(state)
    end
  end
end
