
defmodule TorobBackendWeb.UserView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.UserView
  alias TorobBackendWeb.ShopView
  alias TorobBackendWeb.LikeView
  alias TorobBackendWeb.ProductView
  alias TorobBackendWeb.ReportView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user_with_shop.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end
  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      name: user.name,
      phone: user.phone,
      email: user.email,
      avatar: TorobBackend.UserProfile.url({user.avatar, user}),
    }
  end

  def render("show_with_shop.json", %{user: user}) do
    %{data: render_one(user, UserView, "user_with_shop.json")}
  end


  def render("user_with_shop.json", %{user: user}) do
    IO.inspect user
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      name: user.name,
      phone: user.phone,
      avatar: TorobBackend.UserProfile.url({user.avatar, user}),
      is_admin: user.is_admin,
      shops: render_many(user.shops, ShopView, "show_for_user.json"),
      products: render_many(user.products, ProductView, "show.json"),
      reports: render_many(user.reports, ReportView, "show.json"),
      likes: render_many(user.likes, LikeView, "show_for_user.json")
    }
  end
  def render("jwt.json", %{jwt: jwt , is_admin: is_admin , id: id}) do
    %{
      jwt: jwt,
      is_admin: is_admin,
      id: id
    }
  end

  def render("unauth.json",%{error: error}) do
    %{error: error}
  end
end
