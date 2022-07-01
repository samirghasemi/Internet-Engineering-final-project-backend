defmodule TorobBackendWeb.CategoryView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.CategoryView
  alias TorobBackendWeb.SubcategoryView

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      title: category.title,
      subs: render_many(category.subcategories, SubcategoryView, "subcategory.json")
    }
  end
end
