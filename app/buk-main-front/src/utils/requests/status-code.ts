export function isSuccessStatusCode(statusCode: number): boolean {
  return statusCode >= 200 && statusCode < 300;
}

export function isFailStatusCode(statusCode: number): boolean {
  return !isSuccessStatusCode(statusCode);
}
