import { BooksProvider } from "@/providers/books/books.provider";
import { BooksListError, BooksListOutput } from "@/providers/books/types/books.list.types";
import { BadRequestError } from "@/utils/requests/bad-requests";

export default async function Home() {
  var booksProvider = new BooksProvider();

  const booksRes = await booksProvider.list({});

  if (booksRes.kind == "failure") return handleBookFail(booksRes.error);

  return (
    <div>
      <h1>Books</h1>

      <ul className="flex gap-4">
        {booksRes.value.map(BookCard)}
      </ul>

    </div>
  );
}

function BookCard(book: BooksListOutput) {
  return (
    <div className="w-40 h-60 bg-red-600" key={book.id}>
      {book.title} - {(book.price / 100).toFixed(2)}
    </div>
  )
}

function handleBookFail(error: BadRequestError<BooksListError>) {
  console.error(error)
  return <div>
    <h1>Fail to load books</h1>
    <p>{error.statusCode}</p>
    <p>{error.metatata.message}</p>
  </div>;
}

