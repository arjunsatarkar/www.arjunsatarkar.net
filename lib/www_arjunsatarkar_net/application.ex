defmodule WwwArjunsatarkarNet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    WwwArjunsatarkarNet.Template.compile_templates()
    WwwArjunsatarkarNet.Cache.init()

    {:ok, port} = Application.fetch_env(:www_arjunsatarkar_net, :port)

    children = [
      # Starts a worker by calling: WwwArjunsatarkarNet.Worker.start_link(arg)
      # {WwwArjunsatarkarNet.Worker, arg}
      {Plug.Cowboy,
       scheme: :http, plug: WwwArjunsatarkarNet.Router, ip: {127, 0, 0, 1}, port: port}
    ]

    System.no_halt(true)

    Logger.info("Starting server on http://127.0.0.1:#{Integer.to_string(port)} ...")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WwwArjunsatarkarNet.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
