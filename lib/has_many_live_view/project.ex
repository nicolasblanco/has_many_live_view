defmodule HasManyLiveView.Project do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name
    field :description
  end

  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
