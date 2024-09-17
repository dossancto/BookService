import { Card, CardContent } from "@/components/ui/card";
import Link from "next/link"
import { BooksListOutput } from "@/providers/books/types/books.list.types";

export function BookCard(book: BooksListOutput) {
  return (
    <Card className="w-80 max-w-sm rounded-lg overflow-hidden transition-all hover:shadow-xl" key={book.id}>
      <Link href="#" className="group block relative" prefetch={false}>
        <img
          src="/placeholder.svg"
          alt="Book Cover"
          width={100}
          height={500}
          className="w-full h-[300px] object-cover"
          style={{ aspectRatio: "500/700", objectFit: "cover" }}
        />
        <div className="absolute inset-0 bg-gradient-to-t from-background to-transparent group-hover:from-background/80 group-hover:to-background/80 transition-colors" />
      </Link>
      <CardContent className="p-6 space-y-4">
        <div className="flex items-center justify-between">
          <RatingStars {...book} />
          <div className="bg-primary rounded-full px-3 py-1 text-xs font-medium text-primary-foreground">{book.category}</div>
        </div>
        <h3 className="text-xl font-bold">{book.title}</h3>
        <p className="text-muted-foreground">
          {book.description}
        </p>
      </CardContent>
    </Card>
  )
}

type BookRatingProps = {
  rating?: number
}

function RatingStars({ rating }: BookRatingProps) {
  const MAX_STARS = 5;
  if (rating == undefined || rating < 0) return <div className="text-muted-foreground">No rating</div>;

  const normalizedValue = clamp(rating, 0, MAX_STARS);

  const arr = Array.from(Array(MAX_STARS).keys());

  arr.fill(0, 0, MAX_STARS);
  arr.fill(1, 0, normalizedValue);

  return (
    <div className="flex items-center gap-2">
      {arr.map(r =>
        (r === 1)
          ? <StarIcon className="w-5 h-5 fill-primary" />
          : <StarIcon className="w-5 h-5 fill-muted stroke-muted-foreground" />
      )}

      <span className="text-sm text-muted-foreground">{rating}</span>
    </div>
  );
}

function StarIcon(props: React.SVGProps<SVGSVGElement>) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
    </svg>
  )
}

const clamp = (val: number, min: number, max: number) => Math.min(Math.max(val, min), max)
