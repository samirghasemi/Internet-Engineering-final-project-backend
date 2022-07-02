defmodule TorobBackendWeb.ProductView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.ProductView

  def render("index1.json", %{products: products}) do
    render_many(products, ProductView, "product1.json")
  end

  def render("index.json", %{products: products}) do
    render_many(products, ProductView, "product.json")
  end

  def render("show.json", %{product: product}) do
    render_one(product, ProductView, "product.json")
  end
  def render("show1.json", %{product: product}) do
    render_one(product, ProductView, "product1.json")
  end
  def render("show2.json", %{product: product}) do
    render_one(product, ProductView, "product2.json")
  end

  def render("product.json", %{product: product}) do
    %{
#      id: product.id,
      price: product.price,
      link: product.link,
#      model_id: product.model_id,
#      user_id: product.user_id,
      name: product.shop.name
    }
  end

  def render("product1.json", %{product: product}) do
    %{
      id: product.id,
      price: product.price,
      link: product.link,
      model_id: product.model_id,
      user_id: product.user_id,
      name: product.model.name,
      shop: product.shop.name

    }
  end

  def render("product2.json", %{product: product}) do
    %{
      id: product.id,
      price: product.price,
      link: product.link,
      model_id: product.model_id,
      user_id: product.user_id,
    }
  end
end
