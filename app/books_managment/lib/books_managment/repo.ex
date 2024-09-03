defmodule BooksManagment.Repo do
  use Ecto.Repo,
    otp_app: :books_managment,
    adapter: Ecto.Adapters.Postgres
end
