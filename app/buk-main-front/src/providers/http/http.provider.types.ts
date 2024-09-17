export type HttpRequest<TIn, TOut> = (a: IHttpClient, data: TIn) => TOut;

export type HttpResponseConfig = {
  path: string,
  baseURL: string
};

export type HttpResponse<T> = {
  status: number
  config: HttpResponseConfig
  data: T
}

export interface IHttpClient {
  post<TIn, TOut>(url: string, data: TIn): Promise<HttpResponse<TOut>>;
  get<TOut>(url: string): Promise<HttpResponse<TOut>>;
}

