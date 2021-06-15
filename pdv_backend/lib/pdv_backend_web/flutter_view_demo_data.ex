defmodule PdvBackendWeb.FlutterViewDemoData do
  use Phoenix.DataView
  use FlutterView

  def mount(_params, socket) do
    {:ok, socket}
  end

  deft render(assigns) do
    scaffold(
      app_bar: app_bar(
        title: text("hello world")
      ),
      body: list_view(
        children: [
          text("foobar"),
          text("testing"),
          text("ajsdkasdk"),
          text("foobar"),
          text("testing"),
          text("ajsdkasdk")
        ],
      ),
      floating_action_button: floating_action_button(
        on_pressed_event: "add_post"
      )
    )
  end

  def handle_event(%{"e" => "add_post"}, socket) do
    {:ok, socket}
  end

end
