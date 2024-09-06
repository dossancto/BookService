defmodule BooksManagment.Managment.AuthorValidation do
  use Ecto.Schema
  import Ecto.Changeset

  def validate_date_later_than(changeset, start_field, end_field, msg)
      when is_atom(start_field) and is_atom(end_field) do
    validate_change(changeset, start_field, fn start_field, start_value ->
      a =
        validate_change(changeset, end_field, fn end_field, end_value ->
          if DateTime.compare(start_value, end_value) != :lt do
            [{start_field, msg}]
          else
            []
          end
        end)

      a.errors
    end)
  end
end
