defmodule TorobBackend.StoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TorobBackend.Stores` context.
  """

  @doc """
  Generate a shop.
  """
  def shop_fixture(attrs \\ %{}) do
    {:ok, shop} =
      attrs
      |> Enum.into(%{
        avatar: "some avatar",
        desc: "some desc",
        link: "some link",
        name: "some name"
      })
      |> TorobBackend.Stores.create_shop()

    shop
  end

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        avatar: "some avatar",
        desc: "some desc",
        name: "some name",
        price: 42
      })
      |> TorobBackend.Stores.create_product()

    product
  end
end
