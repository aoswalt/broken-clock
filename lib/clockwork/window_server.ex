defmodule Clockwork.WindowServer do
  @moduledoc """
  Plug `Clockwork.Window` into supervision tree
  """

  use GenServer

  alias Clockwork.Window

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  @impl GenServer
  def init(_) do
    case Window.start_link() do
      {:error, _} = error -> error
      ref -> {:ok, ref}
    end
  end
end
