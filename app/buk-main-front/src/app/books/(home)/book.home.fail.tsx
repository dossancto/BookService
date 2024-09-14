import { BooksListError } from "@/providers/books/types/books.list.types";
import { BadRequestError } from "@/utils/requests/bad-requests";

export function handleBookFail(error: BadRequestError<BooksListError>) {
  console.error(error)
  if (error.statusCode === 503) {
    return <div>
      <h1>Sorry. Books are unavaible now</h1>
    </div>;
  }
  return <div>
    <h1>Fail to load books</h1>
    <p>{error.statusCode}</p>
    <p>{error.metatata.message}</p>
  </div>;
}


