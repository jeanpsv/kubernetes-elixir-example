defmodule KubernetesElixirExample.Greetings.Greeting do
  use Ecto.Schema
  import Ecto.Changeset
  alias KubernetesElixirExample.Greetings.Greeting


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "greetings" do
    field :message, :string

    timestamps()
  end

  @doc false
  def changeset(%Greeting{} = greeting, attrs) do
    greeting
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
