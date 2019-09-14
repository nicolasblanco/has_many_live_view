defmodule HasManyLiveView.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias HasManyLiveView.Project

  schema "users" do
    field :first_name, :string
    field :last_name, :string

    embeds_many :projects, Project

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name])
    |> cast_embed(:projects)
    |> validate_required([:first_name, :last_name])
  end
end
