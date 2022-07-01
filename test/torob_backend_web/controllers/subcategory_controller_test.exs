defmodule TorobBackendWeb.SubcategoryControllerTest do
  use TorobBackendWeb.ConnCase

  import TorobBackend.MenuFixtures

  alias TorobBackend.Menu.Subcategory

  @create_attrs %{
    title: "some title"
  }
  @update_attrs %{
    title: "some updated title"
  }
  @invalid_attrs %{title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all subcategories", %{conn: conn} do
      conn = get(conn, Routes.subcategory_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create subcategory" do
    test "renders subcategory when data is valid", %{conn: conn} do
      conn = post(conn, Routes.subcategory_path(conn, :create), subcategory: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.subcategory_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.subcategory_path(conn, :create), subcategory: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update subcategory" do
    setup [:create_subcategory]

    test "renders subcategory when data is valid", %{conn: conn, subcategory: %Subcategory{id: id} = subcategory} do
      conn = put(conn, Routes.subcategory_path(conn, :update, subcategory), subcategory: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.subcategory_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, subcategory: subcategory} do
      conn = put(conn, Routes.subcategory_path(conn, :update, subcategory), subcategory: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete subcategory" do
    setup [:create_subcategory]

    test "deletes chosen subcategory", %{conn: conn, subcategory: subcategory} do
      conn = delete(conn, Routes.subcategory_path(conn, :delete, subcategory))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.subcategory_path(conn, :show, subcategory))
      end
    end
  end

  defp create_subcategory(_) do
    subcategory = subcategory_fixture()
    %{subcategory: subcategory}
  end
end
