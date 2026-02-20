class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final dynamic error;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, {
        T Function(dynamic json)? fromJsonT,
      }) {
    return ApiResponse<T>(
      success: json['success'] == true ||
          json['status'] == true ||
          json['status'] == 'success',
      message: json['message']?.toString(),
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : json['data'],
      error: json['error'],
    );
  }
}
