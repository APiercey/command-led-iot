defmodule MyhomeWeb.PageController do
  use MyhomeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
