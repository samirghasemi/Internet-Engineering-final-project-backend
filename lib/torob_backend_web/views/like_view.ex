defmodule TorobBackendWeb.LikeView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.LikeView
  alias TorobBackendWeb.ModelView

  def render("index.json", %{likes: likes}) do
      render_many(likes, LikeView, "like.json")
  end

  def render("show.json", %{like: like}) do
     render_one(like, LikeView, "like.json")
  end

  def render("like.json", %{like: like}) do
    %{
      id: like.id,
      is_like: like.is_like,
      user_id: like.user_id,
      model_id: like.model_id
    }
  end

  def render("show_for_user.json", %{like: like}) do
    render_one(like, LikeView, "like_for_user.json")
  end

  def render("like_for_user.json", %{like: like}) do
    IO.inspect like
    %{
      id: like.id,
      user_id: like.user_id,
      model: render_one(like.model, ModelView, "show_for_user.json")
    }
  end
end
