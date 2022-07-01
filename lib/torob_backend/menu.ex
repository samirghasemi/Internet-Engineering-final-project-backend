defmodule TorobBackend.Menu do
  @moduledoc """
  The Menu context.
  """

  import Ecto.Query, warn: false
  alias TorobBackend.Repo

  alias TorobBackend.Menu.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end
  def list_categories_with_subs do
    Repo.all(Category) |> Repo.preload([:subcategories])
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)
  def get_category2!(id), do: Repo.get!(Category, id)|> Repo.preload([:subcategories])

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  alias TorobBackend.Menu.Subcategory

  @doc """
  Returns the list of subcategories.

  ## Examples

      iex> list_subcategories()
      [%Subcategory{}, ...]

  """
  def list_subcategories do
    Repo.all(Subcategory)
  end

  @doc """
  Gets a single subcategory.

  Raises `Ecto.NoResultsError` if the Subcategory does not exist.

  ## Examples

      iex> get_subcategory!(123)
      %Subcategory{}

      iex> get_subcategory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subcategory!(id), do: Repo.get!(Subcategory, id)

  @doc """
  Creates a subcategory.

  ## Examples

      iex> create_subcategory(%{field: value})
      {:ok, %Subcategory{}}

      iex> create_subcategory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subcategory(attrs \\ %{},category_id) do
    category = get_category!(category_id)
    category
    |> Ecto.build_assoc(:subcategories)
    |> Subcategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subcategory.

  ## Examples

      iex> update_subcategory(subcategory, %{field: new_value})
      {:ok, %Subcategory{}}

      iex> update_subcategory(subcategory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subcategory(%Subcategory{} = subcategory, attrs) do
    subcategory
    |> Subcategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subcategory.

  ## Examples

      iex> delete_subcategory(subcategory)
      {:ok, %Subcategory{}}

      iex> delete_subcategory(subcategory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subcategory(%Subcategory{} = subcategory) do
    Repo.delete(subcategory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subcategory changes.

  ## Examples

      iex> change_subcategory(subcategory)
      %Ecto.Changeset{data: %Subcategory{}}

  """
  def change_subcategory(%Subcategory{} = subcategory, attrs \\ %{}) do
    Subcategory.changeset(subcategory, attrs)
  end
end
