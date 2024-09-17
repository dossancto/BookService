import { BooksListError } from "@/providers/books/types/books.list.types";
import { BadRequestError } from "@/utils/requests/bad-requests";

export function handleBookFail(error: BadRequestError<BooksListError>) {
  console.error(error)
  if (error.statusCode === 503) {
    return (
      <div className="w-full h-64 flex justify-center items-center bg-red-600">
        <h1 className="text-3xl text-white">Sorry. Books are unavaible now</h1>
      </div>
    );
  }
  return (
    <div className="w-full h-64 flex justify-center items-center bg-red-600">
      <h1>Fail to load books</h1>
      <p>{error.statusCode}</p>
      <p>{error.metatata.message}</p>
    </div>
  );
}


