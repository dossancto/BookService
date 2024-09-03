defmodule BooksManagment.ManagmentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BooksManagment.Managment` context.
  """

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        bio: "some bio",
        birth_date: ~U[2024-09-02 00:49:00Z],
        contact_email: "some contact_email",
        death_date: ~U[2024-09-02 00:49:00Z],
        display_name: "some display_name",
        full_name: "some full_name",
        image_url: "some image_url",
        location: "some location",
        userId: "some userId"
      })
      |> BooksManagment.Managment.create_author()

    author
  end
end
