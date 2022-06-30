defmodule TorobBackendWeb.ModelControllerTest do
  use TorobBackendWeb.ConnCase

  import TorobBackend.StoresFixtures

  alias TorobBackend.Stores.Model

  @create_attrs %{
    avatar: "some avatar",
    desc: "some desc",
    name: "some name"
  }
  @update_attrs %{
    avatar: "some updated avatar",
    desc: "some updated desc",
    name: "some updated name"
  }
  @invalid_attrs %{avatar: nil, desc: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all models", %{conn: conn} do
      conn = get(conn, Routes.model_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create model" do
    test "renders model when data is valid", %{conn: conn} do
      conn = post(conn, Routes.model_path(conn, :create), model: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.model_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "avatar" => "some avatar",
               "desc" => "some desc",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.model_path(conn, :create), model: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update model" do
    setup [:create_model]

    test "renders model when data is valid", %{conn: conn, model: %Model{id: id} = model} do
      conn = put(conn, Routes.model_path(conn, :update, model), model: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.model_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "avatar" => "some updated avatar",
               "desc" => "some updated desc",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, model: model} do
      conn = put(conn, Routes.model_path(conn, :update, model), model: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete model" do
    setup [:create_model]

    test "deletes chosen model", %{conn: conn, model: model} do
      conn = delete(conn, Routes.model_path(conn, :delete, model))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.model_path(conn, :show, model))
      end
    end
  end

  defp create_model(_) do
    model = model_fixture()
    %{model: model}
  end
end
