defmodule Clockwork.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Clockwork.Worker.start_link(arg)
      {Clockwork.WindowServer, nil}
    ]

    opts = [strategy: :one_for_one, name: Clockwork.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
