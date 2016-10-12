defmodule Crashy.McCrashFace do
  use     GenServer
  require Logger

  def start_link(name) do
    Logger.info "Starting server '#{name}'"
    GenServer.start_link(__MODULE__,
                         name,
                         name: name)
  end

  def crash(pid, reason \\ "too tired to continue") do
    Logger.info " ^^^^^^ ignore this tracing  ^^^^^^"
    GenServer.cast(pid, { :crash, reason })
  end

  def exit(pid) do
    Logger.info " ^^^^^^ ignore this tracing  ^^^^^^"
    GenServer.stop(pid, :normal)
  end
  
  def init(state) do
    Process.flag(:trap_exit, true)
    {:ok, state}
  end

  def handle_cast({:crash, reason}, state) do
    { :stop, reason, state}
  end

  def terminate(reason, state) do
    Logger.info "#{state} is terminating: #{reason}"
  end
end
