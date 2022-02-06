defmodule Rafiyol.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Rafiyol.Repo,
      # Start the Telemetry supervisor
      RafiyolWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Rafiyol.PubSub},
      # Start the Endpoint (http/https)
      RafiyolWeb.Endpoint,
      # Start a worker by calling: Rafiyol.Worker.start_link(arg)
      # {Rafiyol.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rafiyol.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RafiyolWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
