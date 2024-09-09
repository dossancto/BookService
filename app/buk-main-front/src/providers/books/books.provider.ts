import { getAxiosInstance } from "../http/http.provider.axios";
import { HttpRequest } from "../http/http.provider.types";

export function useBookAxios<TIn, TOut>(f: HttpRequest<TIn, TOut>): (d: TIn) => TOut {
  const BASE_URL = getAuthUrl();

  const axiosInstance = getAxiosInstance({
    baseURL: BASE_URL,
  });

  return (d: TIn) => f(axiosInstance, d);
}

function getAuthUrl() {
  const BASE_URL = process.env.BOOKS_URL;

  if (!BASE_URL) {
    throw new Error('BOOKS_URL is not defined');
  }

  return BASE_URL;
}
