defmodule TorobBackendWeb.ShopController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Stores
  alias TorobBackend.Stores.Shop

  action_fallback TorobBackendWeb.FallbackController

  def load_current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def index(conn, _params) do
    shops = Stores.list_shops()
    render(conn, "index.json", shops: shops)
  end

  def create(conn, %{"shop" => shop_params}) do
    with {:ok, %Shop{} = shop} <- Stores.create_shop2(shop_params , load_current_user(conn)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.shop_path(conn, :show, shop))
      |> render("show.json", shop: shop)
    end
  end

  def show(conn, %{"id" => id}) do
    shop = Stores.get_shop!(id)
    render(conn, "show.json", shop: shop)
  end

  def update(conn, %{"id" => id, "shop" => shop_params}) do
    shop = Stores.get_shop!(id)

    with {:ok, %Shop{} = shop} <- Stores.update_shop(shop, shop_params) do
      render(conn, "show.json", shop: shop)
    end
  end

  def delete(conn, %{"id" => id}) do
    shop = Stores.get_shop!(id)

    with {:ok, %Shop{}} <- Stores.delete_shop(shop) do
      send_resp(conn, :no_content, "")
    end
  end
end
