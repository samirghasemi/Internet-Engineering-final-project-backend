defmodule TorobBackendWeb.ShopView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.ShopView
  alias TorobBackendWeb.ProductView
  alias TorobBackendWeb.ReportView

  def render("index.json", %{shops: shops}) do
    %{data: render_many(shops, ShopView, "shop_for_user.json")}
  end

  def render("show_for_user.json", %{shop: shop}) do
    render_one(shop, ShopView, "shop_for_user.json")
  end

  def render("shop_for_user.json", %{shop: shop}) do
    %{
      id: shop.id,
      name: shop.name,
      desc: shop.desc,
      link: shop.link,
      avatar: TorobBackend.ShopProfile.url({shop.avatar, shop})
    }
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
      products: render_many(shop.products, ProductView, "show.json"),
      reports: render_many(shop.reports, ReportView, "show.json"),

      avatar: TorobBackend.ShopProfile.url({shop.avatar, shop})
    }
  end

  def render("shop_created.json", %{shop: shop}) do
    %{
      id: shop.id,
      user_id: shop.user_id,
      name: shop.name,
      desc: shop.desc,
      link: shop.link,
      avatar: TorobBackend.ShopProfile.url({shop.avatar, shop})
    }
  end
end
