defmodule TakeANumberDeluxe do
  # Client API
  use GenServer

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.call(machine, :reset_state)
  end

  # Server callbacks
  @impl true
  def init(init_arg) do
    min = init_arg[:min_number]
    max = init_arg[:max_number]
    timeout = init_arg[:auto_shutdown_timeout] || :infinity

    case TakeANumberDeluxe.State.new(min, max, timeout) do
      {:ok, state} -> {:ok, state, timeout}
      error -> error
    end
  end

  @impl true
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end

  @impl true
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl true
  def handle_call(:queue_new_number, _from, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, response, new_state} -> {:reply, {:ok, response}, new_state, new_state.auto_shutdown_timeout}
      error -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl true
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, response, new_state} -> {:reply, {:ok, response}, new_state, new_state.auto_shutdown_timeout}
      error -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl true
  def handle_call(:reset_state, _from, %{min_number: min_number, max_number: max_number, auto_shutdown_timeout: auto_shutdown_timeout}) do
    init_arg = [
      min_number: min_number,
      max_number: max_number,
      auto_shutdown_timeout: auto_shutdown_timeout
    ]

    {:ok, state, timeout} = init(init_arg)

    {:reply, :ok, state, timeout}
  end
end
