defmodule KubernetesElixirExampleWeb.GreetingView do
  use KubernetesElixirExampleWeb, :view
  alias KubernetesElixirExampleWeb.GreetingView

  def render("index.json", %{greetings: greetings}) do
    %{data: render_many(greetings, GreetingView, "greeting.json")}
  end

  def render("show.json", %{greeting: greeting}) do
    %{data: render_one(greeting, GreetingView, "greeting.json")}
  end

  def render("greeting.json", %{greeting: greeting}) do
    %{id: greeting.id,
      message: greeting.message}
  end
end
