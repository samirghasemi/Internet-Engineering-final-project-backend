defmodule TorobBackendWeb.ShopView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.ShopView

  def render("index.json", %{shops: shops}) do
    %{data: render_many(shops, ShopView, "shop.json")}
  end

  def render("show.json", %{shop: shop}) do
    %{data: render_one(shop, ShopView, "shop.json")}
  end

  def render("shop.json", %{shop: shop}) do
    %{
      id: shop.id,
      user_id: shop.user_id,
      name: shop.name,
      desc: shop.desc,
      link: shop.link,
      avatar: shop.avatar
    }
  end
end
