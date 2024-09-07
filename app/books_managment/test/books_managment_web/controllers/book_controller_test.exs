defmodule BooksManagmentWeb.BookControllerTest do
  use BooksManagmentWeb.ConnCase

  import BooksManagment.BookManagmentFixtures

  alias BooksManagment.BookManagment.Book

  @create_attrs %{
    description: "some description",
    title: "some title",
    category: "programming",
    language: "some language",
    release_date: ~N[2024-09-06 12:35:00],
    summary: "some summary",
    avaible: true,
    images: ["https://some-url.com.br", "https://some-url-2.com.br"],
    page_count: 42,
    price: 2500,
    isbn: "1-56619-909-3"
  }
  @update_attrs %{
    format: "pdf",
    description: "some updated description",
    title: "some updated title",
    category: "english",
    language: "some updated language",
    release_date: ~N[2024-09-07 12:35:00],
    summary: "some updated summary",
    avaible: false,
    images: ["https://some-url-3.com.br"],
    rating: 5,
    page_count: 43,
    price: 3000,
    isbn: "1-56619-909-3"
  }
  @invalid_attrs %{
    format: nil,
    description: nil,
    title: nil,
    category: nil,
    language: nil,
    release_date: nil,
    summary: nil,
    avaible: nil,
    images: nil,
    rating: nil,
    page_count: nil,
    price: nil,
    isbn: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get(conn, ~p"/api/books")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create book" do
    test "renders book when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/books", @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/books/#{id}")
      # {
      #     description: "some description",
      #     title: "some title",
      #     category: "programming",
      #     language: "some language",
      #     release_date: ~N[2024-09-06 12:35:00],
      #     summary: "some summary",
      #     avaible: true,
      #     images: ["https://some-url.com.br", "https://some-url-2.com.br"],
      #     page_count: 42,
      #     price: 2500,
      #     isbn: "978-1-56619-909-4 2"
      #   }
      assert %{
               "id" => ^id,
               "avaible" => true,
               "category" => "programming",
               "description" => "some description",
               "format" => "pdf",
               "images" => ["https://some-url.com.br", "https://some-url-2.com.br"],
               "isbn" => "1-56619-909-3",
               "language" => "some language",
               "page_count" => 42,
               "price" => 2500,
               "rating" => 0,
               "release_date" => "2024-09-06T12:35:00",
               "summary" => "some summary",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/books", book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update book" do
    setup [:create_book]

    test "renders book when data is valid", %{conn: conn, book: %Book{id: id} = book} do
      conn = put(conn, ~p"/api/books/#{book}", book: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/books/#{id}")

      assert %{
             "id" => ^id,
              "avaible" => false,
              "category" => "english",
              "description" => "some updated description",
              "format" => "pdf",
              "images" => ["https://some-url-3.com.br"],
              "isbn" => "1-56619-909-3",
              "language" => "some updated language",
              "page_count" => 43,
              "price" => 3000,
              "rating" => 5,
              "release_date" => "2024-09-07T12:35:00",
              "summary" => "some updated summary",
              "title" => "some updated title"
            } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put(conn, ~p"/api/books/#{book}", book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete book" do
    setup [:create_book]

    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete(conn, ~p"/api/books/#{book}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/books/#{book}")
      end
    end
  end

  defp create_book(_) do
    book = book_fixture()
    %{book: book}
  end
end
