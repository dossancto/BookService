defmodule BooksManagmentWeb.BookController do
  use BooksManagmentWeb, :controller

  alias BooksManagment.BookManagment
  alias BooksManagment.BookManagment.Book

  action_fallback BooksManagmentWeb.FallbackController

  def index(conn, _params) do
    books = BookManagment.list_books()
    render(conn, :index, books: books)
  end

  def create(conn, book_params) do
    with {:ok, %Book{} = book} <- BookManagment.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/books/#{book}")
      |> render(:show, book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = BookManagment.get_book!(id)
    render(conn, :show, book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = BookManagment.get_book!(id)

    with {:ok, %Book{} = book} <- BookManagment.update_book(book, book_params) do
      render(conn, :show, book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = BookManagment.get_book!(id)

    with {:ok, %Book{}} <- BookManagment.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
