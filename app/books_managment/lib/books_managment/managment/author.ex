defmodule BooksManagment.Managment.Author do
  use Ecto.Schema
  import Ecto.Changeset
  import BooksManagment.Managment.AuthorValidation

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "authors" do
    field :location, :string
    field :full_name, :string
    field :display_name, :string
    field :contact_email, :string
    field :birth_date, :utc_datetime
    field :death_date, :utc_datetime
    field :bio, :string
    field :image_url, :string
    field :userId, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [
      :full_name,
      :display_name,
      :contact_email,
      :birth_date,
      :death_date,
      :bio,
      :image_url,
      :userId,
      :location
    ])
    |> validate_required([
      :full_name,
      :display_name,
      :contact_email,
      :birth_date,
      :death_date,
      :bio,
      :image_url,
      :userId,
      :location
    ])
    |> validate_date_later_than(
      :birth_date,
      :death_date,
      "The author can't be dead before birth."
    )
  end
end
