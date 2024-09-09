import { HttpRequest } from "../http/http.provider.types";
import { getAxiosInstance } from "../http/http.provider.axios";

export function useAuthAxios<TIn, TOut>(f: HttpRequest<TIn, TOut>): (d: TIn) => TOut {
  const BASE_URL = getAuthUrl();

  const axiosInstance = getAxiosInstance({
    baseURL: BASE_URL,
  });

  return (d: TIn) => f(axiosInstance, d);
}

function getAuthUrl() {
  const BASE_URL = process.env.AUTH_BASE_URL;

  if (!BASE_URL) {
    throw new Error('AUTH_BASE_URL is not defined');
  }

  return BASE_URL;
}
