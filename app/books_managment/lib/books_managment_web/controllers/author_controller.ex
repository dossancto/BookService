defmodule BooksManagmentWeb.AuthorController do
  use BooksManagmentWeb, :controller

  alias BooksManagment.Managment
  alias BooksManagment.Managment.Author

  action_fallback BooksManagmentWeb.FallbackController

  def index(conn, _params) do
    authors = Managment.list_authors()
    render(conn, :index, authors: authors)
  end

  def create(conn, author_params) do
    with {:ok, %Author{} = author} <- Managment.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/authors/#{author}")
      |> render(:show, author: author)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Managment.get_author!(id)
    render(conn, :show, author: author)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Managment.get_author!(id)

    with {:ok, %Author{} = author} <- Managment.update_author(author, author_params) do
      render(conn, :show, author: author)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Managment.get_author!(id)

    with {:ok, %Author{}} <- Managment.delete_author(author) do
      send_resp(conn, :no_content, "")
    end
  end
end
