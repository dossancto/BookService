defmodule BooksManagment.BookManagment.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :format, :string
    field :description, :string
    field :title, :string
    field :category, :string
    field :language, :string
    field :release_date, :naive_datetime
    field :summary, :string
    field :avaible, :boolean, default: false
    field :images, {:array, :string}
    field :rating, :integer
    field :page_count, :integer
    field :price, :integer
    field :isbn, :string
    field :author, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :description, :language, :release_date, :summary, :avaible, :format, :images, :rating, :page_count, :category, :price, :isbn])
    |> validate_required([:title, :description, :language, :release_date, :summary, :avaible, :format, :images, :rating, :page_count, :category, :price, :isbn])
  end
end
