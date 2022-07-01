defmodule TorobBackendWeb.LikeView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.LikeView

  def render("index.json", %{likes: likes}) do
    %{data: render_many(likes, LikeView, "like.json")}
  end

  def render("show.json", %{like: like}) do
    %{data: render_one(like, LikeView, "like.json")}
  end

  def render("like.json", %{like: like}) do
    %{
      id: like.id,
      is_like: like.is_like,
      user_id: like.user_id,
      model_id: like.model_id
    }
  end
end
