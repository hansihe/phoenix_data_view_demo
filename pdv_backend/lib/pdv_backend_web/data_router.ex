defmodule PdvBackendWeb.DataRouter do
  use Phoenix.DataView.Router

  data "/hello_world", PdvBackendWeb.HelloWorldData

end
