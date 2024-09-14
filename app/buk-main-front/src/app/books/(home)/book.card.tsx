import { BooksListOutput } from "@/providers/books/types/books.list.types";

export function BookCard(book: BooksListOutput) {
  return (
    <div className="w-40 h-60 bg-red-600" key={book.id}>
      {book.title} - {(book.price / 100).toFixed(2)}
    </div>
  )
}
