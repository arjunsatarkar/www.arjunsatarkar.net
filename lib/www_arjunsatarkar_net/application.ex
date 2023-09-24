defmodule WwwArjunsatarkarNet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: WwwArjunsatarkarNet.Worker.start_link(arg)
      # {WwwArjunsatarkarNet.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: WwwArjunsatarkarNet.Router, port: 8000}
    ]

    Logger.info("Starting server...")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WwwArjunsatarkarNet.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
