defmodule TorobBackend.MenuFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TorobBackend.Menu` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> TorobBackend.Menu.create_category()

    category
  end

  @doc """
  Generate a subcategory.
  """
  def subcategory_fixture(attrs \\ %{}) do
    {:ok, subcategory} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> TorobBackend.Menu.create_subcategory()

    subcategory
  end

  @doc """
  Generate a brand.
  """
  def brand_fixture(attrs \\ %{}) do
    {:ok, brand} =
      attrs
      |> Enum.into(%{
        category: "some category",
        subcategory: "some subcategory",
        title: "some title"
      })
      |> TorobBackend.Menu.create_brand()

    brand
  end
end
