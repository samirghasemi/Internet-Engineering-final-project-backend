defmodule TorobBackendWeb.CategoryView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.CategoryView
  alias TorobBackendWeb.SubcategoryView

  def render("index.json", %{categories: categories}) do
    render_many(categories, CategoryView, "category_with_sub.json")
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      title: category.title,
    }
  end

  def render("show_with_sub.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category_with_sub.json")}
  end

  def render("category_with_sub.json", %{category: category}) do
    %{
      id: category.id,
      category: category.title,
      subcategory: render_many(category.subcategories, SubcategoryView, "subcategory_with_brand.json")
    }
  end
end
