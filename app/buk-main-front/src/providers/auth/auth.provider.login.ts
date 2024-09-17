import { LoginInput, LoginOutput, LoginOutputError } from "./types/auth.login.types";
import { Result, success } from "@/utils/errors-handlers/result-pattern";
import { isFailStatusCode } from "@/utils/requests/status-code";
import { BadRequestError, handleHttpFail } from "@/utils/requests/bad-requests";
import { IHttpClient } from "../http/http.provider.types";
import { useAuthAxios } from "./auth.provider";

export async function flogin(a: IHttpClient, input: LoginInput): Promise<Result<LoginOutput, BadRequestError<LoginOutputError>>> {
  const res = await a.post('/login', input);

  if (isFailStatusCode(res.status)) {
    return handleHttpFail(res, "Fail to login");
  }

  const json = res.data;

  const data = json as LoginOutput;

  return success(data);
}

export const loginRecipe = useAuthAxios(flogin);
