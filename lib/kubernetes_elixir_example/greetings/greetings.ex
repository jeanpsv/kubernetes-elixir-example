defmodule KubernetesElixirExample.Greetings do
  @moduledoc """
  The Greetings context.
  """

  import Ecto.Query, warn: false
  alias KubernetesElixirExample.Repo

  alias KubernetesElixirExample.Greetings.Greeting

  @doc """
  Returns the list of greetings.

  ## Examples

      iex> list_greetings()
      [%Greeting{}, ...]

  """
  def list_greetings do
    Repo.all(Greeting)
  end

  @doc """
  Gets a single greeting.

  Raises `Ecto.NoResultsError` if the Greeting does not exist.

  ## Examples

      iex> get_greeting!(123)
      %Greeting{}

      iex> get_greeting!(456)
      ** (Ecto.NoResultsError)

  """
  def get_greeting!(id), do: Repo.get!(Greeting, id)

  @doc """
  Creates a greeting.

  ## Examples

      iex> create_greeting(%{field: value})
      {:ok, %Greeting{}}

      iex> create_greeting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_greeting(attrs \\ %{}) do
    %Greeting{}
    |> Greeting.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a greeting.

  ## Examples

      iex> update_greeting(greeting, %{field: new_value})
      {:ok, %Greeting{}}

      iex> update_greeting(greeting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_greeting(%Greeting{} = greeting, attrs) do
    greeting
    |> Greeting.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Greeting.

  ## Examples

      iex> delete_greeting(greeting)
      {:ok, %Greeting{}}

      iex> delete_greeting(greeting)
      {:error, %Ecto.Changeset{}}

  """
  def delete_greeting(%Greeting{} = greeting) do
    Repo.delete(greeting)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking greeting changes.

  ## Examples

      iex> change_greeting(greeting)
      %Ecto.Changeset{source: %Greeting{}}

  """
  def change_greeting(%Greeting{} = greeting) do
    Greeting.changeset(greeting, %{})
  end
end
