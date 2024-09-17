import { listBooksRecipe } from "@/providers/books/books.provider.list";
import { handleBookFail as HandleBookFail } from "./book.home.fail";
import { BookCard } from "./book.card";
import { groupBy } from 'lodash'
import { BooksListOutput } from "@/providers/books/types/books.list.types";

export default async function Home() {
  const booksRes = await listBooksRecipe({})

  if (booksRes.kind == "failure") return HandleBookFail(booksRes.error);

  const books = booksRes.value

  const categorizedBooks = groupBy(books, b => b.category)

  const a = Object.entries(categorizedBooks)

  return (
    <div className="mx-28 my-8">
      <h1 className="mb-8 text-3xl">Books</h1>

      {a.map(BookCategoryList)}

    </div>
  );
}

function BookCategoryList([category, bookList]: [key: string, value: BooksListOutput[]]) {
  return (
    <div>
      <h2>{category}</h2>

      <div className="flex gap-8 my-8">
        {bookList.map(BookCard)}
      </div>

    </div>
  )
}
