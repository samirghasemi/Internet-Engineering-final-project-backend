defmodule TorobBackendWeb.SubcategoryView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.SubcategoryView

  def render("index.json", %{subcategories: subcategories}) do
    %{data: render_many(subcategories, SubcategoryView, "subcategory.json")}
  end

  def render("show.json", %{subcategory: subcategory}) do
    %{data: render_one(subcategory, SubcategoryView, "subcategory.json")}
  end

  def render("subcategory.json", %{subcategory: subcategory}) do
    %{
      id: subcategory.id,
      title: subcategory.title
    }
  end
end
