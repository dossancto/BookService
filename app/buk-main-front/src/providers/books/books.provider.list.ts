import { Result, success } from "@/utils/errors-handlers/result-pattern";
import { IHttpClient } from "../http/http.provider.types";
import { useBookAxios } from "./books.provider";
import { BadRequestError, handleHttpFail } from "@/utils/requests/bad-requests";
import { isFailStatusCode } from "@/utils/requests/status-code";
import { BooksListInput, BooksListOutput } from "./types/books.list.types";

export async function fListBooksApi(http: IHttpClient, _input: BooksListInput): Promise<Result<BooksListOutput[], BadRequestError<BooksListOutput>>> {
  const res = await http.get('/books');

  if (isFailStatusCode(res.status)) {
    return handleHttpFail(res, "Fail to login");
  }

  const json = res.data;

  const data = json as BooksListOutput[];

  return success(data);
}

export const listBooksRecipe = useBookAxios(fListBooksApi);
