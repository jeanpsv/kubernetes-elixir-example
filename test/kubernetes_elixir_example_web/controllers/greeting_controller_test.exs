defmodule KubernetesElixirExampleWeb.GreetingControllerTest do
  use KubernetesElixirExampleWeb.ConnCase

  alias KubernetesElixirExample.Greetings
  alias KubernetesElixirExample.Greetings.Greeting

  @create_attrs %{message: "some message"}
  @update_attrs %{message: "some updated message"}
  @invalid_attrs %{message: nil}

  def fixture(:greeting) do
    {:ok, greeting} = Greetings.create_greeting(@create_attrs)
    greeting
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all greetings", %{conn: conn} do
      conn = get conn, greeting_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create greeting" do
    test "renders greeting when data is valid", %{conn: conn} do
      conn = post conn, greeting_path(conn, :create), greeting: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, greeting_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "message" => "some message"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, greeting_path(conn, :create), greeting: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update greeting" do
    setup [:create_greeting]

    test "renders greeting when data is valid", %{conn: conn, greeting: %Greeting{id: id} = greeting} do
      conn = put conn, greeting_path(conn, :update, greeting), greeting: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, greeting_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "message" => "some updated message"}
    end

    test "renders errors when data is invalid", %{conn: conn, greeting: greeting} do
      conn = put conn, greeting_path(conn, :update, greeting), greeting: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete greeting" do
    setup [:create_greeting]

    test "deletes chosen greeting", %{conn: conn, greeting: greeting} do
      conn = delete conn, greeting_path(conn, :delete, greeting)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, greeting_path(conn, :show, greeting)
      end
    end
  end

  defp create_greeting(_) do
    greeting = fixture(:greeting)
    {:ok, greeting: greeting}
  end
end
