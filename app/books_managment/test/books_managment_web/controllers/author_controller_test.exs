defmodule BooksManagmentWeb.AuthorControllerTest do
  use BooksManagmentWeb.ConnCase

  import BooksManagment.ManagmentFixtures

  alias BooksManagment.Managment.Author

  @create_attrs %{
    location: "some location",
    full_name: "some full_name",
    display_name: "some display_name",
    contact_email: "some contact_email",
    birth_date: ~U[2024-09-02 00:49:00Z],
    death_date: ~U[2024-09-02 00:49:00Z],
    bio: "some bio",
    image_url: "some image_url",
    userId: "some userId"
  }
  @update_attrs %{
    location: "some updated location",
    full_name: "some updated full_name",
    display_name: "some updated display_name",
    contact_email: "some updated contact_email",
    birth_date: ~U[2024-09-03 00:49:00Z],
    death_date: ~U[2024-09-03 00:49:00Z],
    bio: "some updated bio",
    image_url: "some updated image_url",
    userId: "some updated userId"
  }
  @invalid_attrs %{location: nil, full_name: nil, display_name: nil, contact_email: nil, birth_date: nil, death_date: nil, bio: nil, image_url: nil, userId: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all authors", %{conn: conn} do
      conn = get(conn, ~p"/api/authors")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create author" do
    test "renders author when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/authors", @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/authors/#{id}")

      assert %{
               "id" => ^id,
               "bio" => "some bio",
               "birth_date" => "2024-09-02T00:49:00Z",
               "contact_email" => "some contact_email",
               "death_date" => "2024-09-02T00:49:00Z",
               "display_name" => "some display_name",
               "full_name" => "some full_name",
               "image_url" => "some image_url",
               "location" => "some location",
               "userId" => "some userId"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/authors", author: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update author" do
    setup [:create_author]

    test "renders author when data is valid", %{conn: conn, author: %Author{id: id} = author} do
      conn = put(conn, ~p"/api/authors/#{author}", author: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/authors/#{id}")

      assert %{
               "id" => ^id,
               "bio" => "some updated bio",
               "birth_date" => "2024-09-03T00:49:00Z",
               "contact_email" => "some updated contact_email",
               "death_date" => "2024-09-03T00:49:00Z",
               "display_name" => "some updated display_name",
               "full_name" => "some updated full_name",
               "image_url" => "some updated image_url",
               "location" => "some updated location",
               "userId" => "some updated userId"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, author: author} do
      conn = put(conn, ~p"/api/authors/#{author}", author: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete author" do
    setup [:create_author]

    test "deletes chosen author", %{conn: conn, author: author} do
      conn = delete(conn, ~p"/api/authors/#{author}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/authors/#{author}")
      end
    end
  end

  defp create_author(_) do
    author = author_fixture()
    %{author: author}
  end
end
