import { getAxiosInstance } from "../http/http.provider.axios";
import { HttpRequest } from "../http/http.provider.types";

export function useBookAxios<TIn, TOut>(f: HttpRequest<TIn, TOut>): (d: TIn) => TOut {
  const axiosInstance = getAxiosInstance({
    baseURL: getAuthUrl(),
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
