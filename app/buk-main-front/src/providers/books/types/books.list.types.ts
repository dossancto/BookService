export type BooksListInput = {}

export type BooksListOutput = {
  id: string,
  format: string,
  description: string,
  title: string,
  category: string,
  language: string,
  summary: string,
  avaible: boolean,
  images: string[],
  isbn: string,
  page_count: number,
  price: number,
  rating: number,
  release_date: Date
}

export type BooksListError = {
  unavaible: boolean
}
