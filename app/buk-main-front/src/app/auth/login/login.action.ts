'use server'

import { AuthProvider } from "@/providers/auth/auth.provider"
import { LoginInput, LoginOutput, LoginOutputError } from "@/providers/auth/types/auth.login.types"
import { Result } from "@/utils/errors-handlers/result-pattern"
import { BadRequestError } from "@/utils/requests/bad-requests"
import { cookies } from 'next/headers'

export async function loginUserAction(input: LoginInput): Promise<Result<LoginOutput, BadRequestError<LoginOutputError>>> {
  const auth = new AuthProvider()

  const res = await auth.login(input)

  if (res.kind === 'success') {
    const token = res.value

    // TODO: Move to a center place
    cookies().set('JWT_COOKIE', token.accessToken, { secure: true })
    cookies().set('JWT_REFRESH_TOKEN', token.refreshToken, { secure: true })
  }

  return res
}

