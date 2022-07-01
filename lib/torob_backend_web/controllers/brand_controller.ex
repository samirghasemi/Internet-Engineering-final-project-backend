defmodule TorobBackendWeb.BrandController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Menu
  alias TorobBackend.Menu.Brand

  action_fallback TorobBackendWeb.FallbackController

  def index(conn, _params) do
    brands = Menu.list_brands()
    render(conn, "index.json", brands: brands)
  end

  def create(conn, %{"brand" => brand_params , "subcategory_id" => subcategory_id}) do
    with {:ok, %Brand{} = brand} <- Menu.create_brand(brand_params, subcategory_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.brand_path(conn, :show, brand))
      |> render("show.json", brand: brand)
    end
  end

  def show(conn, %{"id" => id}) do
    brand = Menu.get_brand!(id)
    render(conn, "show.json", brand: brand)
  end

  def update(conn, %{"id" => id, "brand" => brand_params}) do
    brand = Menu.get_brand!(id)

    with {:ok, %Brand{} = brand} <- Menu.update_brand(brand, brand_params) do
      render(conn, "show.json", brand: brand)
    end
  end

  def delete(conn, %{"id" => id}) do
    brand = Menu.get_brand!(id)

    with {:ok, %Brand{}} <- Menu.delete_brand(brand) do
      send_resp(conn, :no_content, "")
    end
  end
end
