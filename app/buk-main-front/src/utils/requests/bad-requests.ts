import { HttpResponse } from "@/providers/http/http.provider.types";
import { fail, Failure } from "../errors-handlers/result-pattern";

export type BadRequestError<T> = {
  statusCode: number;
  error: T | undefined;
  metatata: HttpFailMetadata;
}

export type HttpFailMetadata = {
  endpoint: string;
  baseAddress: string;
  message: string;
  details: string;
}

export type HttpFailInfos = {
  baseUrl: string,
  module: string
}

export function handleHttpFail<TError>(res: HttpResponse<any>, message: string | undefined = undefined): Failure<BadRequestError<TError>> {
  const expectedError = res.data as TError | undefined

  const path = res.config.path

  const fallbackMessage = `Request to ${path} failed with status code ${res.status}`

  const err = {
    metatata: {
      message: message ?? fallbackMessage,
      endpoint: path,
      baseAddress: res.config.baseURL,
      details: res.data
    },
    statusCode: res.status,
    error: expectedError,
  } as BadRequestError<TError>

  return fail(err);
}

