import axios, { AxiosInstance } from "axios";
import { Result, success } from "@/utils/errors-handlers/result-pattern";
import { isFailStatusCode } from "@/utils/requests/status-code";
import { BadRequestError, handleAxiosFail } from "@/utils/requests/bad-requests";
import { BooksListError, BooksListInput, BooksListOutput } from "./types/books.list.types";

export class BooksProvider {
  private axiosInstance: AxiosInstance

  constructor(a: AxiosInstance | undefined = undefined) {
    if (a) {
      this.axiosInstance = a;
      this.axiosInstance.defaults.validateStatus = () => true
      return;
    }

    const BASE_URL = process.env.AUTH_BOOKS_URL;

    if (!BASE_URL) {
      throw new Error('AUTH_BOOKS_URL is not defined');
    }

    this.axiosInstance = axios.create({
      baseURL: BASE_URL,
    });

    this.axiosInstance.defaults.validateStatus = () => true
  }

  async list(_input: BooksListInput): Promise<Result<BooksListOutput[], BadRequestError<BooksListError>>> {
    const res = await this.axiosInstance.get('/books');

    if (isFailStatusCode(res.status)) {
      return handleAxiosFail(res);
    }

    const json = res.data;

    const data = json as BooksListOutput[];

    return success(data);
  }
}

