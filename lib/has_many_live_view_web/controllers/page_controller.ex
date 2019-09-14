defmodule HasManyLiveViewWeb.PageController do
  use HasManyLiveViewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
