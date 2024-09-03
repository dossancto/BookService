defmodule Booksadmin.Repo do
  use Ecto.Repo,
    otp_app: :booksadmin,
    adapter: Ecto.Adapters.Postgres
end
