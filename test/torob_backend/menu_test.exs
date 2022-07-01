defmodule TorobBackend.MenuTest do
  use TorobBackend.DataCase

  alias TorobBackend.Menu

  describe "categories" do
    alias TorobBackend.Menu.Category

    import TorobBackend.MenuFixtures

    @invalid_attrs %{title: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Menu.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Menu.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Category{} = category} = Menu.create_category(valid_attrs)
      assert category.title == "some title"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Category{} = category} = Menu.update_category(category, update_attrs)
      assert category.title == "some updated title"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_category(category, @invalid_attrs)
      assert category == Menu.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Menu.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Menu.change_category(category)
    end
  end

  describe "subcategories" do
    alias TorobBackend.Menu.Subcategory

    import TorobBackend.MenuFixtures

    @invalid_attrs %{title: nil}

    test "list_subcategories/0 returns all subcategories" do
      subcategory = subcategory_fixture()
      assert Menu.list_subcategories() == [subcategory]
    end

    test "get_subcategory!/1 returns the subcategory with given id" do
      subcategory = subcategory_fixture()
      assert Menu.get_subcategory!(subcategory.id) == subcategory
    end

    test "create_subcategory/1 with valid data creates a subcategory" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Subcategory{} = subcategory} = Menu.create_subcategory(valid_attrs)
      assert subcategory.title == "some title"
    end

    test "create_subcategory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_subcategory(@invalid_attrs)
    end

    test "update_subcategory/2 with valid data updates the subcategory" do
      subcategory = subcategory_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Subcategory{} = subcategory} = Menu.update_subcategory(subcategory, update_attrs)
      assert subcategory.title == "some updated title"
    end

    test "update_subcategory/2 with invalid data returns error changeset" do
      subcategory = subcategory_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_subcategory(subcategory, @invalid_attrs)
      assert subcategory == Menu.get_subcategory!(subcategory.id)
    end

    test "delete_subcategory/1 deletes the subcategory" do
      subcategory = subcategory_fixture()
      assert {:ok, %Subcategory{}} = Menu.delete_subcategory(subcategory)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_subcategory!(subcategory.id) end
    end

    test "change_subcategory/1 returns a subcategory changeset" do
      subcategory = subcategory_fixture()
      assert %Ecto.Changeset{} = Menu.change_subcategory(subcategory)
    end
  end

  describe "brands" do
    alias TorobBackend.Menu.Brand

    import TorobBackend.MenuFixtures

    @invalid_attrs %{category: nil, subcategory: nil, title: nil}

    test "list_brands/0 returns all brands" do
      brand = brand_fixture()
      assert Menu.list_brands() == [brand]
    end

    test "get_brand!/1 returns the brand with given id" do
      brand = brand_fixture()
      assert Menu.get_brand!(brand.id) == brand
    end

    test "create_brand/1 with valid data creates a brand" do
      valid_attrs = %{category: "some category", subcategory: "some subcategory", title: "some title"}

      assert {:ok, %Brand{} = brand} = Menu.create_brand(valid_attrs)
      assert brand.category == "some category"
      assert brand.subcategory == "some subcategory"
      assert brand.title == "some title"
    end

    test "create_brand/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_brand(@invalid_attrs)
    end

    test "update_brand/2 with valid data updates the brand" do
      brand = brand_fixture()
      update_attrs = %{category: "some updated category", subcategory: "some updated subcategory", title: "some updated title"}

      assert {:ok, %Brand{} = brand} = Menu.update_brand(brand, update_attrs)
      assert brand.category == "some updated category"
      assert brand.subcategory == "some updated subcategory"
      assert brand.title == "some updated title"
    end

    test "update_brand/2 with invalid data returns error changeset" do
      brand = brand_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_brand(brand, @invalid_attrs)
      assert brand == Menu.get_brand!(brand.id)
    end

    test "delete_brand/1 deletes the brand" do
      brand = brand_fixture()
      assert {:ok, %Brand{}} = Menu.delete_brand(brand)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_brand!(brand.id) end
    end

    test "change_brand/1 returns a brand changeset" do
      brand = brand_fixture()
      assert %Ecto.Changeset{} = Menu.change_brand(brand)
    end
  end
end
