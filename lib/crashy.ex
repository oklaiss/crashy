defmodule Crashy do
  use Application

  # Uncomment just one of the following three values
  # @strategy :one_for_one
   @strategy :one_for_all
  #@strategy :rest_for_one

  # Uncomment just one of the following three values
  @restart :permanent
  # @restart :transient
  # @restart :temporary

  def start(_type, _args) do
    children = [ :one, :two, :three ] |> Enum.map(&worker_spec/1)
    opts = [
      strategy: @strategy,
      name: Crashy.Supervisor
    ]
    Supervisor.start_link(children, opts)
  end

  def worker_spec(name) do
    import Supervisor.Spec, warn: false
    worker(Crashy.McCrashFace,
           [ name ],
           id: name,
           restart: @restart
    )
  end

end
