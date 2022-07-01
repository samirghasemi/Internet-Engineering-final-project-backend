defmodule TorobBackendWeb.ModelView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.ModelView

  def render("index.json", %{models: models}) do
    %{data: render_many(models, ModelView, "model.json")}
  end

  def render("show.json", %{model: model}) do
    %{data: render_one(model, ModelView, "model.json")}
  end

  def render("model.json", %{model: model}) do
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
