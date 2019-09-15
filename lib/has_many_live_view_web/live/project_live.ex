defmodule HasManyLiveViewWeb.ProjectLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Form
  import Ecto.Changeset
  alias HasManyLiveView.Accounts.{User, Project}
  alias HasManyLiveViewWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
      <h1>User</h1>

      <%= f = form_for @changeset, Routes.user_path(@socket, :update, @user), [phx_change: :validate] %>
        <input type="hidden" name="_csrf_token" value="<%= @csrf_token %>" />
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

  def mount(%{csrf_token: csrf_token}, socket) do
    user = User |> Ecto.Query.first |> HasManyLiveView.Repo.one
    changeset = User.changeset(user, %{})

    {:ok, assign(socket, changeset: changeset,
                         user: user,
                         csrf_token: csrf_token)}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = User.changeset(socket.assigns.user, user_params)

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
