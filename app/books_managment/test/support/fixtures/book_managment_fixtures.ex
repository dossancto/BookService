defmodule BooksManagment.BookManagmentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BooksManagment.BookManagment` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        avaible: true,
        category: "programming",
        description: "some description",
        format: "pdf",
        images: ["https://some-url.com.br", "https://some-url-2.com.br"],
        isbn: "1-56619-909-3",
        language: "some language",
        page_count: 42,
        price: 2000,
        rating: 0,
        release_date: ~N[2024-09-06 12:35:00],
        summary: "some summary",
        title: "some title"
      })
      |> BooksManagment.BookManagment.create_book()

    book
  end
end
