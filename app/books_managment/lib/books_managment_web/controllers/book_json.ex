defmodule BooksManagmentWeb.BookJSON do
  alias BooksManagment.BookManagment.Book

  @doc """
  Renders a list of books.
  """
  def index(%{books: books}) do
    for(book <- books, do: data(book))
  end

  @doc """
  Renders a single book.
  """
  def show(%{book: book}) do
    %{data: data(book)}
  end

  defp data(%Book{} = book) do
    %{
      id: book.id,
      title: book.title,
      description: book.description,
      language: book.language,
      release_date: book.release_date,
      summary: book.summary,
      avaible: book.avaible,
      format: book.format,
      images: book.images,
      rating: book.rating,
      page_count: book.page_count,
      category: book.category,
      price: book.price,
      isbn: book.isbn
    }
  end
end
