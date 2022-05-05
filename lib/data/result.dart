enum Status { loading, success, error }

class Result<T> {
  Status status;
  T? data;
  Exception? exception;

  Result.loading() : status = Status.loading;
  Result.success(this.data) : status = Status.success;
  Result.error(this.exception) : status = Status.error;

  @override
  String toString() {
    return 'Status: $status \nexception: ${exception?.toString()} \nData: $data?';
  }
}