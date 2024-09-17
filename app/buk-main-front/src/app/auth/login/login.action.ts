'use server'

import { setLoginTokensToCookies } from "@/actions/auth-cookies"
import { loginRecipe } from "@/providers/auth/auth.provider.login"

import { LoginInput, LoginOutput, LoginOutputError } from "@/providers/auth/types/auth.login.types"
import { Result } from "@/utils/errors-handlers/result-pattern"
import { BadRequestError } from "@/utils/requests/bad-requests"

export async function loginUserAction(input: LoginInput): Promise<Result<LoginOutput, BadRequestError<LoginOutputError>>> {
  var res = await loginRecipe(input);

  if (res.kind === 'success') {
    const token = res.value

    await setLoginTokensToCookies(token);
  }

  return res
}

