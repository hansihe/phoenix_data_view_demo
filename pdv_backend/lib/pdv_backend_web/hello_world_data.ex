defmodule PdvBackendWeb.HelloWorldData do
  use Phoenix.DataView

  def mount(_params, socket) do
    posts = [
      gen_post(),
      gen_post()
    ]

    socket = 
      socket
      |> assign(:categories, [%{id: 0, posts: posts}])


    {:ok, socket}
  end

  deft render(assigns) do
    %{
      categories: for category <- assigns.categories do
        keyed category.id do
          %{
            posts: for post <- category.posts do
              keyed post.id, track(render_post(post))
            end
          }
        end
      end
    }
  end

  #deft render(assigns) do
  #  %{
  #    posts: for post <- assigns.posts do
  #      keyed post.id, render_post(post)
  #    end
  #  }
  #end

  deft render_post(post) do
    %{
      title: post.title,
      text: post.text,
    }
  end

  def handle_event(%{"e" => "add_post"}, socket) do
    [%{posts: posts}] = socket.assigns.categories

    socket =
      socket
      |> assign(:categories, [%{id: 0, posts: [gen_post() | posts]}])

    {:ok, socket}
  end

  def gen_post do
    %{
      id: 10,
      title: "Foobar generated blogpost",
      text: ""
    }
  end

end
