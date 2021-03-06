defmodule HasManyLiveViewWeb.Router do
  use HasManyLiveViewWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HasManyLiveViewWeb do
    pipe_through :browser

    resources "/users", UserController
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", HasManyLiveViewWeb do
  #   pipe_through :api
  # end
end
