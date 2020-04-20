defmodule MyhomeWeb.Router do
  use MyhomeWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyhomeWeb do
    pipe_through :browser

    get "/", PageController, :index

    if Mix.env() == :dev do
      live_dashboard "/dashboard"
    end
  end

  scope "/api", MyhomeWeb do
    pipe_through :api

    patch "/set_luminosity", LuminosityController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyhomeWeb do
  #   pipe_through :api
  # end
end
