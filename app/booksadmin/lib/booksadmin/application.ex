defmodule Booksadmin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BooksadminWeb.Telemetry,
      Booksadmin.Repo,
      {DNSCluster, query: Application.get_env(:booksadmin, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Booksadmin.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Booksadmin.Finch},
      # Start a worker by calling: Booksadmin.Worker.start_link(arg)
      # {Booksadmin.Worker, arg},
      # Start to serve requests, typically the last entry
      BooksadminWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Booksadmin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BooksadminWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
