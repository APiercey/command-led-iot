defmodule Myhome.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    start_supervisor()
  end

  def start_supervisor do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      # Myhome.Repo,
      # Start the endpoint when the application starts
      MyhomeWeb.Endpoint,
      Myhome.InstreamConnection,
      {Tortoise.Connection,
       [
         client_id: "myhome",
         server: {Tortoise.Transport.Tcp, host: "mosquitto", port: 1883},
         handler: {MqttHandler, []},
         subscriptions: [{"home", 0}]
       ]}
      # Starts a worker by calling: Myhome.Worker.start_link(arg)
      # {Myhome.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Myhome.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MyhomeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
