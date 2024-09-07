export type Success<T> = { kind: 'success', value: T };
export type Failure<E> = { kind: 'failure', error: E };
export type Result<T, E> = Success<T> | Failure<E>;

export function success<T>(value: T): Success<T> {
  return { kind: 'success', value: value }
}

export function fail<E>(value: E): Failure<E> {
  return { kind: 'failure', error: value }
}
