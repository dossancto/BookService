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
        category: "some category",
        description: "some description",
        format: "some format",
        images: ["option1", "option2"],
        isbn: "some isbn",
        language: "some language",
        page_count: 42,
        price: 42,
        rating: 42,
        release_date: ~N[2024-09-06 12:35:00],
        summary: "some summary",
        title: "some title"
      })
      |> BooksManagment.BookManagment.create_book()

    book
  end
end
