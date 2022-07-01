defmodule TorobBackendWeb.LikeControllerTest do
  use TorobBackendWeb.ConnCase

  import TorobBackend.AccountsFixtures

  alias TorobBackend.Accounts.Like

  @create_attrs %{
    model_id: "some model_id",
    user_id: "some user_id"
  }
  @update_attrs %{
    model_id: "some updated model_id",
    user_id: "some updated user_id"
  }
  @invalid_attrs %{model_id: nil, user_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all likes", %{conn: conn} do
      conn = get(conn, Routes.like_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create like" do
    test "renders like when data is valid", %{conn: conn} do
      conn = post(conn, Routes.like_path(conn, :create), like: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.like_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "model_id" => "some model_id",
               "user_id" => "some user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.like_path(conn, :create), like: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update like" do
    setup [:create_like]

    test "renders like when data is valid", %{conn: conn, like: %Like{id: id} = like} do
      conn = put(conn, Routes.like_path(conn, :update, like), like: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.like_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "model_id" => "some updated model_id",
               "user_id" => "some updated user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, like: like} do
      conn = put(conn, Routes.like_path(conn, :update, like), like: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete like" do
    setup [:create_like]

    test "deletes chosen like", %{conn: conn, like: like} do
      conn = delete(conn, Routes.like_path(conn, :delete, like))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.like_path(conn, :show, like))
      end
    end
  end

  defp create_like(_) do
    like = like_fixture()
    %{like: like}
  end
end
