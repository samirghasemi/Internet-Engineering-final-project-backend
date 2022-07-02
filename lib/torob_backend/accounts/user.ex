defmodule TorobBackend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema
  alias Pbkdf2

  schema "users" do
    field :avatar, TorobBackend.UserProfile.Type
    field :email, :string
    field :phone, :string
    field :password, :string
    field :username, :string
    field :name, :string
    field :is_admin, :boolean

    has_many :shops , TorobBackend.Stores.Shop
    has_many :products, TorobBackend.Stores.Product
    has_many :reports, TorobBackend.Stores.Report
    has_many :likes, TorobBackend.Accounts.Like


    timestamps()
  end


  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password , :email, :is_admin, :phone])
    |> cast_attachments(attrs,[:avatar])
    |> validate_required([:username, :password, :email])
    |> validate_email
    |> validate_password
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Pbkdf2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 8, max: 80)
    |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
  end
end
