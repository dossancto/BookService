import { fail, Result, success } from "@/utils/errors-handlers/result-pattern";
import { IHttpClient } from "../http/http.provider.types";
import { useBookAxios } from "./books.provider";
import { BadRequestError } from "@/utils/requests/bad-requests";
import { isFailStatusCode } from "@/utils/requests/status-code";
import { BooksListError, BooksListInput, BooksListOutput } from "./types/books.list.types";
import { AxiosError } from "axios";

export async function fListBooksApi(http: IHttpClient, _input: BooksListInput): Promise<Result<BooksListOutput[], BadRequestError<BooksListError>>> {
  const path = '/books';

  try {
    const res = await http.get(path);

    if (isFailStatusCode(res.status)) {
      return handleHttpFail(res, "Fail to login");
    }

    const json = res.data as BooksListOutput[];

    return success(json);

  } catch (err) {
    return handleHttpFail(err, path);
  }
}

function handleHttpFail(err: any, path: string) {
  if (err instanceof AxiosError) {

    if (err.code === 'ECONNREFUSED') {
      const msg = {
        statusCode: 503,
        metatata: {
          message: 'Fail to connect to server',
          endpoint: path,
          details: err.message
        },
      } as BadRequestError<BooksListError>

      return fail(msg)
    }

    const msg = {
      statusCode: 500,
      metatata: {
        message: 'Request failed',
        endpoint: path,
        details: err.message
      },
    } as BadRequestError<BooksListError>

    return fail(msg)
  }

  return handleHttpFail({
    status: 500,
    config: { path, baseURL: '' },
    data: err
  }, "Fail to login");
}



export const listBooksRecipe = useBookAxios(fListBooksApi);
