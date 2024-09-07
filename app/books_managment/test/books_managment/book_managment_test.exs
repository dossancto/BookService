defmodule BooksManagment.BookManagmentTest do
  use BooksManagment.DataCase

  alias BooksManagment.BookManagment

  describe "books" do
    alias BooksManagment.BookManagment.Book

    import BooksManagment.BookManagmentFixtures

    @invalid_attrs %{format: nil, description: nil, title: nil, category: nil, language: nil, release_date: nil, summary: nil, avaible: nil, images: nil, rating: nil, page_count: nil, price: nil, isbn: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert BookManagment.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert BookManagment.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{format: "pdf", description: "some description", title: "some title", category: "programming", language: "some language", release_date: ~N[2024-09-06 12:35:00], summary: "some summary", avaible: true, images: ["https://some-url.com.br", "https://some-url-2.com.br"], rating: 42, page_count: 42, price: 2000, isbn: "1-56619-909-3"}

      assert {:ok, %Book{} = book} = BookManagment.create_book(valid_attrs)
      assert book.format == "pdf"
      assert book.description == "some description"
      assert book.title == "some title"
      assert book.category == "programming"
      assert book.language == "some language"
      assert book.release_date == ~N[2024-09-06 12:35:00]
      assert book.summary == "some summary"
      assert book.avaible == true
      assert book.images == ["https://some-url.com.br", "https://some-url-2.com.br"]
      assert book.rating == 42
      assert book.page_count == 42
      assert book.price == 2000
      assert book.isbn == "1-56619-909-3"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BookManagment.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{format: "pdf", description: "some updated description", title: "some updated title", category: "english", language: "some updated language", release_date: ~N[2024-09-07 12:35:00], summary: "some updated summary", avaible: false, images: ["https://some-url-3.com.br"], rating: 43, page_count: 43, price: 2500, isbn: "1-56619-909-3"}

      assert {:ok, %Book{} = book} = BookManagment.update_book(book, update_attrs)
      assert book.format == "pdf"
      assert book.description == "some updated description"
      assert book.title == "some updated title"
      assert book.category == "english"
      assert book.language == "some updated language"
      assert book.release_date == ~N[2024-09-07 12:35:00]
      assert book.summary == "some updated summary"
      assert book.avaible == false
      assert book.images == ["https://some-url-3.com.br"]
      assert book.rating == 43
      assert book.page_count == 43
      assert book.price == 2500
      assert book.isbn == "1-56619-909-3"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = BookManagment.update_book(book, @invalid_attrs)
      assert book == BookManagment.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = BookManagment.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> BookManagment.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = BookManagment.change_book(book)
    end
  end
end
