
defmodule TorobBackendWeb.UserView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.UserView
  alias TorobBackendWeb.ShopView

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
      email: user.email,
      avatar: TorobBackend.UserProfile.url({user.avatar, user}),
    }
  end

  def render("show_with_shop.json", %{user: user}) do
    %{data: render_one(user, UserView, "user_with_shop.json")}
  end


  def render("user_with_shop.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      avatar: TorobBackend.UserProfile.url({user.avatar, user}),
      shops: render_many(user.shops, ShopView, "show_for_user.json")
    }
  end
  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("unauth.json",_nothing) do
    %{error: :unauthorized}
  end
end
