defmodule BooksManagment.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :language, :string
      add :release_date, :naive_datetime
      add :summary, :string
      add :avaible, :boolean, default: false, null: false
      add :format, :string
      add :images, {:array, :string}
      add :rating, :integer
      add :page_count, :integer
      add :category, :string
      add :price, :integer
      add :isbn, :string
      add :author, references(:authors, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:books, [:author])
  end
end
