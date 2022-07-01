defmodule TorobBackendWeb.SubcategoryView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.SubcategoryView
  alias TorobBackendWeb.BrandView

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

  def render("show_with_brand.json", %{subcategory: subcategory}) do
    %{data: render_one(subcategory, SubcategoryView, "subcategory_with_brand.json")}
  end

  def render("subcategory_with_brand.json", %{subcategory: subcategory}) do
#    IO.inspect subcategory.brands
    %{
      id: subcategory.id,
      title: subcategory.title,
      names[
    {
        "category": "موبایل و تبلت",
        "id": 1,
        "subcategory": [
            {
                "id": 1,
                "names": [
                    {
                        "id": 1,
…    }
]: render_many(subcategory.brands, BrandView, "brand.json")
    }
  end
end
