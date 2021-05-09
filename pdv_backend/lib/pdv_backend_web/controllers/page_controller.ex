defmodule PdvBackendWeb.PageController do
  use PdvBackendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
