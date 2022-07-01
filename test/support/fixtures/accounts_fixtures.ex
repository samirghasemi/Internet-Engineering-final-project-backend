defmodule TorobBackend.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TorobBackend.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password: "some password",
        username: "some username"
      })
      |> TorobBackend.Accounts.create_user()

    user
  end

  @doc """
  Generate a like.
  """
  def like_fixture(attrs \\ %{}) do
    {:ok, like} =
      attrs
      |> Enum.into(%{
        model_id: "some model_id",
        user_id: "some user_id"
      })
      |> TorobBackend.Accounts.create_like()

    like
  end

  @doc """
  Generate a like.
  """
  def like_fixture(attrs \\ %{}) do
    {:ok, like} =
      attrs
      |> Enum.into(%{
        is_like: true,
        model_id: "some model_id",
        user_id: "some user_id"
      })
      |> TorobBackend.Accounts.create_like()

    like
  end
end
