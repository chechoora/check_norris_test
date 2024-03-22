sealed class Result<T> {}

class ErrorResult<T> extends Result<T> {
  final String message;

  ErrorResult({required this.message});
}

class DataResult<T> extends Result<T> {
  final T data;

  DataResult({required this.data});
}
