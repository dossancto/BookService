defmodule BooksManagment.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :full_name, :string
      add :display_name, :string
      add :contact_email, :string
      add :birth_date, :utc_datetime
      add :death_date, :utc_datetime
      add :bio, :string
      add :image_url, :string
      add :userId, :string
      add :location, :string

      timestamps(type: :utc_datetime)
    end
  end
end
