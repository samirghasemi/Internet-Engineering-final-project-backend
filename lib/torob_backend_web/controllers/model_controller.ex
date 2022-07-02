defmodule TorobBackendWeb.ModelController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Stores
  alias TorobBackend.Stores.Model

  action_fallback TorobBackendWeb.FallbackController

  plug :exists when action in [:edit, :update, :delete, :show]

  def exists(%{params: %{"id" => model_id}} = conn, _) do
    model_id = String.to_integer(model_id)
    model = Stores.get_model(model_id)
    if model == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "this link is not exists!"})
      |> halt()
    else
      conn
    end
  end

  def index(conn, _params) do
    models = Stores.list_models()
    render(conn, "index.json", models: models)
  end

  def create(conn, %{"model" => model_params , "category_id" => category_id, "subcategory_id" => subcategory_id, "brand_id"=> brand_id}) do
    with {:ok, %Model{} = model} <- Stores.create_model(model_params, category_id , subcategory_id, brand_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.model_path(conn, :show, model))
      |> render("show.json", model: model)
    end
  end

  def show(conn, %{"id" => id}) do
    model = Stores.get_model2!(id)
    render(conn, "model_with_product.json", model: model)
  end

#  def show_all(conn, %{"id" => id}) do
#    model = Stores.get_model!(id)
#    render(conn, "show.json", model: model)
#  end

  def update(conn, %{"id" => id, "model" => model_params}) do
    model = Stores.get_model!(id)

    with {:ok, %Model{} = model} <- Stores.update_model(model, model_params) do
      render(conn, "show.json", model: model)
    end
  end

  def delete(conn, %{"id" => id}) do
    model = Stores.get_model!(id)

    with {:ok, %Model{}} <- Stores.delete_model(model) do
      send_resp(conn, :no_content, "")
    end
  end
#
#  def search(conn, params)do
#    res = Stores.search_like(word)
#  end
end
