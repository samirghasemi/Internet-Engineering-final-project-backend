defmodule TorobBackendWeb.ShopController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Stores
  alias TorobBackend.Stores.Shop
  alias TorobBackend.Stores

  action_fallback TorobBackendWeb.FallbackController

#  plug :exists when action in [:edit, :update, :delete, :show]
#  plug :check_user when action in [:update, :edit, :delete]

  def exists(%{params: %{"id" => shop_id}} = conn, _) do
    shop_id = String.to_integer(shop_id)
    shop = Stores.get_shop(shop_id)
    if shop == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "this link is not exists!"})
      |> halt()
    else
      conn
    end
  end

  def check_user(%{params: %{"id" => shop_id}} = conn, _) do
    shop_id = String.to_integer(shop_id)
    shop = Stores.get_shop(shop_id)
    if (shop.user_id == load_current_user(conn).id) do
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
    shops = Stores.list_shops()
    render(conn, "index.json", shops: shops)
  end

  def create(conn, %{"shop" => shop_params}) do
    with {:ok, %Shop{} = shop} <- Stores.create_shop2(shop_params , load_current_user(conn)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.shop_path(conn, :show, shop))
      |> render("shop_created.json", shop: shop)
    end
  end

  def show(conn, %{"id" => id}) do
    shop = Stores.get_shop!(id)
    render(conn, "
user[password]
Text
1234534567Ads1@
.json", shop: shop)
  end

  def update(conn, %{"id" => id, "shop" => shop_params}) do
    shop = Stores.get_shop!(id)

    with {:ok, %Shop{} = shop} <- Stores.update_shop(shop, shop_params) do
      render(conn, "shop_created.json", shop: shop)
    end
  end

  def delete(conn, %{"id" => id}) do
    shop = Stores.get_shop!(id)

    with {:ok, %Shop{}} <- Stores.delete_shop(shop) do
      send_resp(conn, :no_content, "")
    end
  end
end
