defmodule TorobBackendWeb.ProductView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      price: product.price,
      model_id: product.model_id,
      user_id: product.user_id,
      shop_id: product.shop_id
    }
  end
end
