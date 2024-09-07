export type BadRequestError<T> = {
  statusCode: number;
  message: string;
  error: T | undefined;
  details: string;
} 
