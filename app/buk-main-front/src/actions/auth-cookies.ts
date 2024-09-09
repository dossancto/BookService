'use server'

import { LoginOutput } from "@/providers/auth/types/auth.login.types"
import { cookies } from "next/headers"

export async function setLoginTokensToCookies(token: LoginOutput) {
  const now = Date.now()
  const expiresAt = now + token.expiresIn * 1000

  cookies().set('JWT_COOKIE', token.accessToken, { secure: true })
  cookies().set('JWT_REFRESH_TOKEN', token.refreshToken, { secure: true })
  cookies().set('JWT_EXPIRES_AT', expiresAt.toString())
}

