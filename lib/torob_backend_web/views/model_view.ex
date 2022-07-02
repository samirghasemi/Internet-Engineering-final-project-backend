defmodule TorobBackendWeb.ModelView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.ModelView
  alias TorobBackendWeb.ProductView

  def render("index.json", %{models: models}) do
    render_many(models, ModelView, "model_for_all.json")
  end

  def render("model_with_product.json", %{model: model}) do
    %{
      id: model.id,
      name: model.name,
      img: model.image,
      category: model.category_id,
      subcategory: model.subcategory_id,
      brand: model.brand_id,
      minPrice: model.min_price,
      maxPrice: model.max_price,
      specification: %{
        ram: model.ram,
        battery: model.battery,
        screen_size: model.screen_size,
        storage: model.storage
      },
      stores: render_many(model.products, ProductView, "show.json"),

      #      avatar: TorobBackend.ModelProfile.url({model.avatar, model})
    }
  end

  def render("model_for_all.json", %{model: model}) do
    price = case TorobBackend.Stores.get_min_price_modal(model.id) do
      nil ->
        0
      p ->
        p
    end
    %{
      id: model.id,
      name: model.name,
      desc: model.desc,
      img: model.image,
      price: price,
      category: model.category_id,
      subcategory: model.subcategory_id,
      brand: model.brand_id,
      #      avatar: TorobBackend.ModelProfile.url({model.avatar, model})
    }
  end
  def render("show.json", %{model: model}) do
    %{data: render_one(model, ModelView, "model.json")}
  end

  def render("model.json", %{model: model}) do
    price = case TorobBackend.Stores.get_min_price_modal(model.id) do
      nil ->
        0
      p ->
        p
    end
    %{
      id: model.id,
      name: model.name,
      desc: model.desc,
      img: model.image,
      price: price,
      category: model.category_id,
      subcategory: model.subcategory_id,
      brand: model.brand_id,
      meta: %{
        ram: model.ram,
        battery: model.battery,
        screen_size: model.screen_size,
        storage: model.storage
      }
#      avatar: TorobBackend.ModelProfile.url({model.avatar, model})
    }
  end

  def render("show_for_user.json", %{model: model}) do
    render_one(model, ModelView, "model_for_user.json")
  end

  def render("model_for_user.json", %{model: model}) do
    price = case TorobBackend.Stores.get_min_price_modal(model.id) do
      nil ->
        0
      p ->
        p
    end
    %{
      id: model.id,
      name: model.name,
      desc: model.desc,
      category: model.category_id,
      img: model.image,
      price: price,
      subcategory: model.subcategory_id,
      brand: model.brand_id,
      meta: %{
        ram: model.ram,
        battery: model.battery,
        screen_size: model.screen_size,
        storage: model.storage
      }
      #      avatar: TorobBackend.ModelProfile.url({model.avatar, model})
    }
  end
end
