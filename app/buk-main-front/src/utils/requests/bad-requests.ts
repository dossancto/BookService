import { AxiosResponse } from "axios";
import { fail, Failure } from "../errors-handlers/result-pattern";

export type BadRequestError<T> = {
  statusCode: number;
  error: T | undefined;
  metatata: AxiosFailMetadata;
}

export type AxiosFailMetadata = {
  endpoint: string;
  baseAddress: string;
  message: string;
  details: string;
}

export type AxiosFailInfos = {
  baseUrl: string,
  module: string
}

export function handleAxiosFail<TError>(res: AxiosResponse<any, any>, message: string | undefined = undefined): Failure<BadRequestError<TError>> {
  const expectedError = res.data as TError | undefined

  const path = res.config.url

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

