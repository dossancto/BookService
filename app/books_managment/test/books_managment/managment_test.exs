defmodule BooksManagment.ManagmentTest do
  use BooksManagment.DataCase

  alias BooksManagment.Managment

  describe "authors" do
    alias BooksManagment.Managment.Author

    import BooksManagment.ManagmentFixtures

    @invalid_attrs %{location: nil, full_name: nil, display_name: nil, contact_email: nil, birth_date: nil, death_date: nil, bio: nil, image_url: nil, userId: nil}

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Managment.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Managment.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      valid_attrs = %{location: "some location", full_name: "some full_name", display_name: "some display_name", contact_email: "some contact_email", birth_date: ~U[2024-09-02 00:49:00Z], death_date: ~U[2024-09-02 00:49:00Z], bio: "some bio", image_url: "some image_url", userId: "some userId"}

      assert {:ok, %Author{} = author} = Managment.create_author(valid_attrs)
      assert author.location == "some location"
      assert author.full_name == "some full_name"
      assert author.display_name == "some display_name"
      assert author.contact_email == "some contact_email"
      assert author.birth_date == ~U[2024-09-02 00:49:00Z]
      assert author.death_date == ~U[2024-09-02 00:49:00Z]
      assert author.bio == "some bio"
      assert author.image_url == "some image_url"
      assert author.userId == "some userId"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Managment.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      update_attrs = %{location: "some updated location", full_name: "some updated full_name", display_name: "some updated display_name", contact_email: "some updated contact_email", birth_date: ~U[2024-09-03 00:49:00Z], death_date: ~U[2024-09-03 00:49:00Z], bio: "some updated bio", image_url: "some updated image_url", userId: "some updated userId"}

      assert {:ok, %Author{} = author} = Managment.update_author(author, update_attrs)
      assert author.location == "some updated location"
      assert author.full_name == "some updated full_name"
      assert author.display_name == "some updated display_name"
      assert author.contact_email == "some updated contact_email"
      assert author.birth_date == ~U[2024-09-03 00:49:00Z]
      assert author.death_date == ~U[2024-09-03 00:49:00Z]
      assert author.bio == "some updated bio"
      assert author.image_url == "some updated image_url"
      assert author.userId == "some updated userId"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Managment.update_author(author, @invalid_attrs)
      assert author == Managment.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Managment.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Managment.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Managment.change_author(author)
    end
  end
end
