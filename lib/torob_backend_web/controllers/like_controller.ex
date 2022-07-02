defmodule TorobBackendWeb.LikeController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Accounts
  alias TorobBackend.Accounts.Like

  action_fallback TorobBackendWeb.FallbackController

  def load_current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def index(conn, _params) do
    likes = Accounts.list_likes()
    render(conn, "index.json", likes: likes)
  end

  def create(conn, %{"like" => like_params, "model_id"=> model_id}) do
    check = Accounts.get_like_with_user_and_model(load_current_user(conn).id , model_id) |> IO.inspect
    case check do
    nil ->
      with {:ok, %Like{} = like} <- Accounts.create_like2(like_params, load_current_user(conn),model_id) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.like_path(conn, :show, like))
        |> render("show.json", like: like)
      end
    c ->
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.like_path(conn, :show, c))
      |> render("show.json", like: c)
    end

  end

  def show(conn, %{"id" => id}) do
    like = Accounts.get_like!(id)
    render(conn, "show.json", like: like)
  end

  def update(conn, %{"id" => id, "like" => like_params}) do
    like = Accounts.get_like!(id)

    with {:ok, %Like{} = like} <- Accounts.update_like(like, like_params) do
      render(conn, "show.json", like: like)
    end
  end

  def delete(conn, %{"id" => id}) do
    like = Accounts.get_like!(id)

    with {:ok, %Like{}} <- Accounts.delete_like(like) do
      send_resp(conn, :no_content, "")
    end
  end
end
