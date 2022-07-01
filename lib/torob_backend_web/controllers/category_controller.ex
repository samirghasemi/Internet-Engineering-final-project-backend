defmodule TorobBackendWeb.CategoryController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Menu
  alias TorobBackend.Menu.Category

  action_fallback TorobBackendWeb.FallbackController

  def index(conn, _params) do
    categories = Menu.list_categories_with_subs()
    render(conn, "index.json", categories: categories)
  end

  def create(conn, %{"category" => category_params}) do
    with {:ok, %Category{} = category} <- Menu.create_category(category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.category_path(conn, :show, category))
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Menu.get_category2!(id) |> IO.inspect
    render(conn, "show_with_sub.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Menu.get_category!(id)

    with {:ok, %Category{} = category} <- Menu.update_category(category, category_params) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Menu.get_category!(id)

    with {:ok, %Category{}} <- Menu.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
