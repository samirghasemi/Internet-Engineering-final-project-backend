defmodule TorobBackend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema
  alias Pbkdf2

  schema "users" do
    field :avatar, TorobBackend.UserProfile.Type
    field :email, :string
    field :password, :string
    field :username, :string
    field :is_admin, :boolean

    has_many :shops , TorobBackend.Stores.Shop
    has_many :products, TorobBackend.Stores.Product


    timestamps()
  end


  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password , :email])
    |> cast_attachments(attrs,[:avatar])
    |> validate_required([:username, :password, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Pbkdf2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
