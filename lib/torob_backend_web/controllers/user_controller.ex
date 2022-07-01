defmodule TorobBackendWeb.UserController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Accounts
  alias TorobBackend.Accounts.User
  alias TorobBackend.Accounts.Guardian


  action_fallback TorobBackendWeb.FallbackController

  plug :exists when action in [:edit , :update , :delete , :show]
  plug :check_user when action in [:update , :edit , :delete , :show ]

  def exists(%{params: %{"id" => user_id}} = conn , _) do
    user_id = String.to_integer(user_id)
    user = Accounts.get_user_all(user_id)
    if user == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "this link is not exists!"})
      |> halt()
    else
      conn
    end
  end

  def check_user(%{params: %{"id" => user_id}} = conn,_) do
    user_id = String.to_integer(user_id)
    user = Accounts.get_user_all(user_id)
    if (user == load_current_user(conn)) do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "you can not see this!"})
      |> halt()
    end
  end

  def load_current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def index(conn, _params) do
    users = Accounts.list_users2()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) , Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def sign_in(conn, %{"username" => username , "password"=> password})do
    case Accounts.token_sign_in(username, password) do
      {:ok , token , _claims} ->
        conn
        |> render("jwt.json" , jwt: token)
      _ ->
        conn
        |> put_status(:unauthorized)
        |> render("unauth.json" , error: "unauthorized")
    end
  end

  def log_out(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user2!(id)
    render(conn, "show_with_shop.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
