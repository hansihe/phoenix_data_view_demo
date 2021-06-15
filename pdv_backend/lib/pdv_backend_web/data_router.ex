defmodule PdvBackendWeb.DataRouter do
  use Phoenix.DataView.Router

  data "/hello_world", PdvBackendWeb.HelloWorldData

  data "/flutter_view_demo", PdvBackendWeb.FlutterViewDemoData

end
