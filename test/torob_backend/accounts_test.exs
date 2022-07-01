defmodule TorobBackend.AccountsTest do
  use TorobBackend.DataCase

  alias TorobBackend.Accounts

  describe "users" do
    alias TorobBackend.Accounts.User

    import TorobBackend.AccountsFixtures

    @invalid_attrs %{email: nil, password: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", password: "some password", username: "some username"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", password: "some updated password", username: "some updated username"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "likes" do
    alias TorobBackend.Accounts.Like

    import TorobBackend.AccountsFixtures

    @invalid_attrs %{model_id: nil, user_id: nil}

    test "list_likes/0 returns all likes" do
      like = like_fixture()
      assert Accounts.list_likes() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert Accounts.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      valid_attrs = %{model_id: "some model_id", user_id: "some user_id"}

      assert {:ok, %Like{} = like} = Accounts.create_like(valid_attrs)
      assert like.model_id == "some model_id"
      assert like.user_id == "some user_id"
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      update_attrs = %{model_id: "some updated model_id", user_id: "some updated user_id"}

      assert {:ok, %Like{} = like} = Accounts.update_like(like, update_attrs)
      assert like.model_id == "some updated model_id"
      assert like.user_id == "some updated user_id"
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_like(like, @invalid_attrs)
      assert like == Accounts.get_like!(like.id)
    end

    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = Accounts.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = Accounts.change_like(like)
    end
  end

  describe "likes" do
    alias TorobBackend.Accounts.Like

    import TorobBackend.AccountsFixtures

    @invalid_attrs %{is_like: nil, model_id: nil, user_id: nil}

    test "list_likes/0 returns all likes" do
      like = like_fixture()
      assert Accounts.list_likes() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert Accounts.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      valid_attrs = %{is_like: true, model_id: "some model_id", user_id: "some user_id"}

      assert {:ok, %Like{} = like} = Accounts.create_like(valid_attrs)
      assert like.is_like == true
      assert like.model_id == "some model_id"
      assert like.user_id == "some user_id"
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      update_attrs = %{is_like: false, model_id: "some updated model_id", user_id: "some updated user_id"}

      assert {:ok, %Like{} = like} = Accounts.update_like(like, update_attrs)
      assert like.is_like == false
      assert like.model_id == "some updated model_id"
      assert like.user_id == "some updated user_id"
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_like(like, @invalid_attrs)
      assert like == Accounts.get_like!(like.id)
    end

    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = Accounts.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = Accounts.change_like(like)
    end
  end
end
