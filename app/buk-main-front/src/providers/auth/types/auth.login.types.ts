export type LoginInput = {
  email: string;
  password: string;
}

export type LoginOutput = {
  tokenType: string;
  accessToken: string;
  expiresIn: number;
  refreshToken: string;
}

export type LoginOutputError = {
  detail: string;
  title: string;
  type: string;
}
