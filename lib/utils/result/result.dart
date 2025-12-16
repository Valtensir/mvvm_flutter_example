abstract class Result<T> {
  const Result();

  factory Result.ok(T value) = Ok._;
  factory Result.error(Exception error) = Error._;
}

final class Ok<T> extends Result<T> {
  final T value;

  const Ok._(this.value);
}

final class Error<T> extends Result<T> {
  Exception error;

  Error._(this.error);
}

extension ResultExtension on Object {
  Result ok() => Result.ok(this);
}

extension ExceptionExtension on Exception {
  Result error() => Result.error(this);
}

extension ResultCasting<T> on Result<T> {
  Ok<T> asOk() => this as Ok<T>;
  Error<T> asError() => this as Error<T>;
}