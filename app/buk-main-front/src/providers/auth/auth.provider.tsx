import axios, { AxiosInstance } from "axios";
import { LoginInput, LoginOutput, LoginOutputError } from "./types/auth.login.types";
import { fail, Result, success } from "@/utils/errors-handlers/result-pattern";
import { isFailStatusCode } from "@/utils/requests/status-code";
import { BadRequestError } from "@/utils/requests/bad-requests";

export class AuthProvider {
  private axiosInstance: AxiosInstance

  constructor(a: AxiosInstance | undefined = undefined) {
    if (a) {
      this.axiosInstance = a;
      this.axiosInstance.defaults.validateStatus = () => true
      return;
    }

    const BASE_URL = process.env.AUTH_BASE_URL;

    if (!BASE_URL) {
      throw new Error('AUTH_BASE_URL is not defined');
    }

    this.axiosInstance = axios.create({
      baseURL: BASE_URL,
    });

    this.axiosInstance.defaults.validateStatus = () => true
  }

  async login(input: LoginInput): Promise<Result<LoginOutput, BadRequestError<LoginOutputError>>> {
    const res = await this.axiosInstance.post('/login', input);

    if (isFailStatusCode(res.status)) {
      const expectedError = res.data as LoginOutputError | undefined

      const err = {
        statusCode: res.status,
        error: expectedError,
        message: 'Login Failed',
        details: res.data
      } as BadRequestError<LoginOutputError>

      return fail(err);
    }

    const json = res.data;

    const data = json as LoginOutput;

    return success(data);
  }
}
