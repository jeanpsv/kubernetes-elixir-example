defmodule KubernetesElixirExample.GreetingsTest do
  use KubernetesElixirExample.DataCase

  alias KubernetesElixirExample.Greetings

  describe "greetings" do
    alias KubernetesElixirExample.Greetings.Greeting

    @valid_attrs %{message: "some message"}
    @update_attrs %{message: "some updated message"}
    @invalid_attrs %{message: nil}

    def greeting_fixture(attrs \\ %{}) do
      {:ok, greeting} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Greetings.create_greeting()

      greeting
    end

    test "list_greetings/0 returns all greetings" do
      greeting = greeting_fixture()
      assert Greetings.list_greetings() == [greeting]
    end

    test "get_greeting!/1 returns the greeting with given id" do
      greeting = greeting_fixture()
      assert Greetings.get_greeting!(greeting.id) == greeting
    end

    test "create_greeting/1 with valid data creates a greeting" do
      assert {:ok, %Greeting{} = greeting} = Greetings.create_greeting(@valid_attrs)
      assert greeting.message == "some message"
    end

    test "create_greeting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Greetings.create_greeting(@invalid_attrs)
    end

    test "update_greeting/2 with valid data updates the greeting" do
      greeting = greeting_fixture()
      assert {:ok, greeting} = Greetings.update_greeting(greeting, @update_attrs)
      assert %Greeting{} = greeting
      assert greeting.message == "some updated message"
    end

    test "update_greeting/2 with invalid data returns error changeset" do
      greeting = greeting_fixture()
      assert {:error, %Ecto.Changeset{}} = Greetings.update_greeting(greeting, @invalid_attrs)
      assert greeting == Greetings.get_greeting!(greeting.id)
    end

    test "delete_greeting/1 deletes the greeting" do
      greeting = greeting_fixture()
      assert {:ok, %Greeting{}} = Greetings.delete_greeting(greeting)
      assert_raise Ecto.NoResultsError, fn -> Greetings.get_greeting!(greeting.id) end
    end

    test "change_greeting/1 returns a greeting changeset" do
      greeting = greeting_fixture()
      assert %Ecto.Changeset{} = Greetings.change_greeting(greeting)
    end
  end
end
