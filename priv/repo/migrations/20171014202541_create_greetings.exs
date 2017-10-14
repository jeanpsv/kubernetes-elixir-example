defmodule KubernetesElixirExample.Repo.Migrations.CreateGreetings do
  use Ecto.Migration

  def change do
    create table(:greetings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :message, :string

      timestamps()
    end

  end
end
