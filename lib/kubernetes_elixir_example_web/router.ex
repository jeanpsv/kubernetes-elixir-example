defmodule KubernetesElixirExampleWeb.Router do
  use KubernetesElixirExampleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KubernetesElixirExampleWeb do
    pipe_through :api
    resources "/greetings", GreetingController, except: [:new, :edit]
  end
end
