defmodule BooksManagment.BookManagment.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :format, :string, default: "pdf"
    field :description, :string
    field :title, :string
    field :category, :string
    field :language, :string
    field :release_date, :naive_datetime
    field :summary, :string
    field :avaible, :boolean, default: false
    field :images, {:array, :string}
    field :rating, :integer, default: 0
    field :page_count, :integer
    field :price, :integer
    field :isbn, :string
    field :author, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [
      :title,
      :description,
      :language,
      :release_date,
      :summary,
      :avaible,
      :rating,
      :format,
      :images,
      :page_count,
      :category,
      :price,
      :isbn
    ])
    |> validate_required([
      :title,
      :description,
      :language,
      :release_date,
      :summary,
      :rating,
      :avaible,
      :format,
      :images,
      :page_count,
      :category,
      :price,
      :isbn
    ])
    |> validate_number(:price, greater_than_or_equal_to: 2000)
    |> validate_format(:isbn, ~r/^(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)[\d-]+$/)
    |> validate_book_format
    |> validate_images
    |> validate_book_category
  end

  defp validate_book_category(changeset) do
    valid_categories = ["programming", "mathematics", "history", "english", "social studies"]

    valid_categories_str = Enum.join(valid_categories, ", ")

    changeset
    |> validate_inclusion(:category, valid_categories,
      message: "must be one of [#{valid_categories_str}]"
    )
  end

  defp validate_book_format(changeset) do
    valid_formats = ["pdf"]

    valid_formats_str = Enum.join(valid_formats, ", ")

    changeset
    |> validate_inclusion(:format, valid_formats,
      message: "must be one of [#{valid_formats_str}]"
    )
  end

  defp validate_images(changeset) do
    images = get_field(changeset, :images)

    if images != nil and Enum.all?(images, &valid_url?/1) do
      changeset
    else
      add_error(changeset, :images, "Make sure all urls are valid")
    end
  end

  defp valid_url?(url) do
    ~r/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/i
    |> Regex.match?(url)
  end
end
