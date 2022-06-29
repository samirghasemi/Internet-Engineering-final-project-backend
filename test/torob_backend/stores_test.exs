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
end
