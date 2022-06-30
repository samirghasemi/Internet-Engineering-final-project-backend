defmodule TorobBackend.StoresTest do
  use TorobBackend.DataCase

  alias TorobBackend.Stores

  describe "shops" do
    alias TorobBackend.Stores.Shop

    import TorobBackend.StoresFixtures

    @invalid_attrs %{avatar: nil, desc: nil, link: nil, name: nil}

    test "list_shops/0 returns all shops" do
      shop = shop_fixture()
      assert Stores.list_shops() == [shop]
    end

    test "get_shop!/1 returns the shop with given id" do
      shop = shop_fixture()
      assert Stores.get_shop!(shop.id) == shop
    end

    test "create_shop/1 with valid data creates a shop" do
      valid_attrs = %{avatar: "some avatar", desc: "some desc", link: "some link", name: "some name"}

      assert {:ok, %Shop{} = shop} = Stores.create_shop(valid_attrs)
      assert shop.avatar == "some avatar"
      assert shop.desc == "some desc"
      assert shop.link == "some link"
      assert shop.name == "some name"
    end

    test "create_shop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stores.create_shop(@invalid_attrs)
    end

    test "update_shop/2 with valid data updates the shop" do
      shop = shop_fixture()
      update_attrs = %{avatar: "some updated avatar", desc: "some updated desc", link: "some updated link", name: "some updated name"}

      assert {:ok, %Shop{} = shop} = Stores.update_shop(shop, update_attrs)
      assert shop.avatar == "some updated avatar"
      assert shop.desc == "some updated desc"
      assert shop.link == "some updated link"
      assert shop.name == "some updated name"
    end

    test "update_shop/2 with invalid data returns error changeset" do
      shop = shop_fixture()
      assert {:error, %Ecto.Changeset{}} = Stores.update_shop(shop, @invalid_attrs)
      assert shop == Stores.get_shop!(shop.id)
    end

    test "delete_shop/1 deletes the shop" do
      shop = shop_fixture()
      assert {:ok, %Shop{}} = Stores.delete_shop(shop)
      assert_raise Ecto.NoResultsError, fn -> Stores.get_shop!(shop.id) end
    end

    test "change_shop/1 returns a shop changeset" do
      shop = shop_fixture()
      assert %Ecto.Changeset{} = Stores.change_shop(shop)
    end
  end

  describe "models" do
    alias TorobBackend.Stores.Model

    import TorobBackend.StoresFixtures

    @invalid_attrs %{avatar: nil, desc: nil, name: nil}

    test "list_models/0 returns all models" do
      model = model_fixture()
      assert Stores.list_models() == [model]
    end

    test "get_model!/1 returns the model with given id" do
      model = model_fixture()
      assert Stores.get_model!(model.id) == model
    end

    test "create_model/1 with valid data creates a model" do
      valid_attrs = %{avatar: "some avatar", desc: "some desc", name: "some name"}

      assert {:ok, %Model{} = model} = Stores.create_model(valid_attrs)
      assert model.avatar == "some avatar"
      assert model.desc == "some desc"
      assert model.name == "some name"
    end

    test "create_model/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stores.create_model(@invalid_attrs)
    end

    test "update_model/2 with valid data updates the model" do
      model = model_fixture()
      update_attrs = %{avatar: "some updated avatar", desc: "some updated desc", name: "some updated name"}

      assert {:ok, %Model{} = model} = Stores.update_model(model, update_attrs)
      assert model.avatar == "some updated avatar"
      assert model.desc == "some updated desc"
      assert model.name == "some updated name"
    end

    test "update_model/2 with invalid data returns error changeset" do
      model = model_fixture()
      assert {:error, %Ecto.Changeset{}} = Stores.update_model(model, @invalid_attrs)
      assert model == Stores.get_model!(model.id)
    end

    test "delete_model/1 deletes the model" do
      model = model_fixture()
      assert {:ok, %Model{}} = Stores.delete_model(model)
      assert_raise Ecto.NoResultsError, fn -> Stores.get_model!(model.id) end
    end

    test "change_model/1 returns a model changeset" do
      model = model_fixture()
      assert %Ecto.Changeset{} = Stores.change_model(model)
    end
  end

  describe "products" do
    alias TorobBackend.Stores.Product

    import TorobBackend.StoresFixtures

    @invalid_attrs %{price: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Stores.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Stores.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{price: 42}

      assert {:ok, %Product{} = product} = Stores.create_product(valid_attrs)
      assert product.price == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stores.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{price: 43}

      assert {:ok, %Product{} = product} = Stores.update_product(product, update_attrs)
      assert product.price == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Stores.update_product(product, @invalid_attrs)
      assert product == Stores.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Stores.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Stores.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Stores.change_product(product)
    end
  end
end
