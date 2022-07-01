defmodule TorobBackendWeb.SubcategoryController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Menu
  alias TorobBackend.Menu.Subcategory

  action_fallback TorobBackendWeb.FallbackController

  def index(conn, _params) do
    subcategories = Menu.list_subcategories()
    render(conn, "index.json", subcategories: subcategories)
  end

  def create(conn, %{"subcategory" => subcategory_params , "category_id" => category_id}) do
    with {:ok, %Subcategory{} = subcategory} <- Menu.create_subcategory(subcategory_params, category_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.subcategory_path(conn, :show, subcategory))
      |> render("show.json", subcategory: subcategory)
    end
  end

  def show(conn, %{"id" => id}) do
    subcategory = Menu.get_subcategory!(id)
    render(conn, "show.json", subcategory: subcategory)
  end

  def update(conn, %{"id" => id, "subcategory" => subcategory_params}) do
    subcategory = Menu.get_subcategory!(id)

    with {:ok, %Subcategory{} = subcategory} <- Menu.update_subcategory(subcategory, subcategory_params) do
      render(conn, "show.json", subcategory: subcategory)
    end
  end

  def delete(conn, %{"id" => id}) do
    subcategory = Menu.get_subcategory!(id)

    with {:ok, %Subcategory{}} <- Menu.delete_subcategory(subcategory) do
      send_resp(conn, :no_content, "")
    end
  end
end
