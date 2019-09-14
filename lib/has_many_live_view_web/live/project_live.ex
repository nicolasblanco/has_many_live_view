defmodule HasManyLiveViewWeb.ProjectLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Form
  import Ecto.Changeset
  alias HasManyLiveView.{User, Project}

  def render(assigns) do
    ~L"""
      <h1>User</h1>

      <%= f = form_for @changeset, "#", [phx_change: :validate] %>
        <%= label f, :first_name %>
        <%= text_input f, :first_name %>
        <br/>
        <%= label f, :last_name %>
        <%= text_input f, :last_name %>

        <h3>Projects</h3>

        <%= inputs_for f, :projects, fn fp -> %>
          <%= label fp, :name %>
          <%= text_input fp, :name %>

          <%= label fp, :description %>
          <%= textarea fp, :description %>

          <button type="button" phx-click="remove_project" phx-value-index="<%= fp.index %>">Remove project</button>
        <% end %>
        <br>

        <button phx-click="add_project" type="button">Add project</button>
        <br/>

        <%= submit "Save" %>
      </form>
    """
  end

  def mount(_session, socket) do
    changeset = User.changeset(%User{}, %{})

    {:ok, assign(socket, :changeset, changeset)}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = User.changeset(%User{}, user_params)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("remove_project", %{"index" => index_string}, socket) do
    index = String.to_integer(index_string)
    projects = socket.assigns.changeset
               |> get_field(:projects, [])
               |> List.delete_at(index)

    changeset = socket.assigns.changeset
               |> put_embed(:projects, projects)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("add_project", _, socket) do
    projects = socket.assigns.changeset
               |> get_field(:projects, [])
    changeset = socket.assigns.changeset
                |> put_embed(:projects, projects ++ [%Project{}])

    {:noreply, assign(socket, :changeset, changeset)}
  end
end
