defmodule BooksManagmentWeb.AuthorJSON do
  alias BooksManagment.Managment.Author

  @doc """
  Renders a list of authors.
  """
  def index(%{authors: authors}) do
    %{data: for(author <- authors, do: data(author))}
  end

  @doc """
  Renders a single author.
  """
  def show(%{author: author}) do
    %{data: data(author)}
  end

  defp data(%Author{} = author) do
    %{
      id: author.id,
      full_name: author.full_name,
      display_name: author.display_name,
      contact_email: author.contact_email,
      birth_date: author.birth_date,
      death_date: author.death_date,
      bio: author.bio,
      image_url: author.image_url,
      userId: author.userId,
      location: author.location
    }
  end
end
