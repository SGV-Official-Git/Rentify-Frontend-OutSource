class ApiResponse<T> {
  T? data;
  bool statusCode = false;
  String? message;
  int? status;
  ApiResponse(this.data, this.message, this.statusCode, this.status);
}
