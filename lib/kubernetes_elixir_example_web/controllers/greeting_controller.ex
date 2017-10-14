defmodule KubernetesElixirExampleWeb.GreetingController do
  use KubernetesElixirExampleWeb, :controller

  alias KubernetesElixirExample.Greetings
  alias KubernetesElixirExample.Greetings.Greeting

  action_fallback KubernetesElixirExampleWeb.FallbackController

  def index(conn, _params) do
    greetings = Greetings.list_greetings()
    render(conn, "index.json", greetings: greetings)
  end

  def create(conn, %{"greeting" => greeting_params}) do
    with {:ok, %Greeting{} = greeting} <- Greetings.create_greeting(greeting_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", greeting_path(conn, :show, greeting))
      |> render("show.json", greeting: greeting)
    end
  end

  def show(conn, %{"id" => id}) do
    greeting = Greetings.get_greeting!(id)
    render(conn, "show.json", greeting: greeting)
  end

  def update(conn, %{"id" => id, "greeting" => greeting_params}) do
    greeting = Greetings.get_greeting!(id)

    with {:ok, %Greeting{} = greeting} <- Greetings.update_greeting(greeting, greeting_params) do
      render(conn, "show.json", greeting: greeting)
    end
  end

  def delete(conn, %{"id" => id}) do
    greeting = Greetings.get_greeting!(id)
    with {:ok, %Greeting{}} <- Greetings.delete_greeting(greeting) do
      send_resp(conn, :no_content, "")
    end
  end
end
