import { listBooksRecipe } from "@/providers/books/books.provider.list";
import { BookCard } from "./book.card";
import { handleBookFail as HandleBookFail } from "./book.home.fail";

export default async function Home() {
  const booksRes = await listBooksRecipe({})

  if (booksRes.kind == "failure") return HandleBookFail(booksRes.error);

  return (
    <div>
      <h1>Books</h1>

      <ul className="flex gap-4">
        {booksRes.value.map(BookCard)}
      </ul>

    </div>
  );
}
