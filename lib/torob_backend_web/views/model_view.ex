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
      minPrice: 1000,
      maxPrice: 2000,
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
    %{
      id: model.id,
      name: model.name,
      desc: model.desc,
      img: model.image,
      category: model.category_id,
      subcategory: model.subcategory_id,
      brand: model.brand_id,
      price: 1000
      #      avatar: TorobBackend.ModelProfile.url({model.avatar, model})
    }
  end
  def render("show.json", %{model: model}) do
    %{data: render_one(model, ModelView, "model.json")}
  end

  def render("model.json", %{model: model}) do
    %{
      id: model.id,
      name: model.name,
      desc: model.desc,
      img: model.image,
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
    %{
      id: model.id,
      name: model.name,
      desc: model.desc,
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
end
