defmodule TorobBackendWeb.ProductController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Stores
  alias TorobBackend.Stores.Product

  action_fallback TorobBackendWeb.FallbackController

  plug :product_exists when action in [:edit, :update, :delete, :show]
  plug :check_user when action in [:update, :edit, :delete]
  plug :model_exists when action in [:create]
  plug :shop_exists when action in [:create]


  def product_exists(%{params: %{"id" => product_id}} = conn, _) do
    product_id = String.to_integer(product_id)
    product = Stores.get_model(product_id)
    if product == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "this product is not exists!"})
      |> halt()
    else
      conn
    end
  end

  def model_exists(%{params: %{"model_id" => model_id}} = conn, _) do
    model_id = String.to_integer(model_id)
    model = Stores.get_model(model_id)
    if model == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "this model is not exists!"})
      |> halt()
    else
      conn
    end
  end

  def shop_exists(%{params: %{"shop_id" => shop_id}} = conn, _) do
    shop_id = String.to_integer(shop_id)
    shop = Stores.get_shop(shop_id)
    if shop == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "this shop is not exists!"})
      |> halt()
    else
      conn
    end
  end

  def check_user(%{params: %{"id" => product_id}} = conn, _) do
    product_id = String.to_integer(product_id)
    product = Stores.get_shop(product_id)
    if (product.user_id == load_current_user(conn).id) do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "you can not see this!"})
      |> halt()
    end
  end

  def load_current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def index(conn, _params) do
    products = Stores.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params , "model_id"=>model_id ,"shop_id"=>shop_id }) do
    model_id = String.to_integer(model_id)
    shop_id = String.to_integer(shop_id)

    with {:ok, %Product{} = product} <- Stores.create_product2(product_params,load_current_user(conn),model_id,shop_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Stores.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Stores.get_product!(id)

    with {:ok, %Product{} = product} <- Stores.update_product(product, product_params) do
      render(conn, "show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Stores.get_product!(id)

    with {:ok, %Product{}} <- Stores.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
