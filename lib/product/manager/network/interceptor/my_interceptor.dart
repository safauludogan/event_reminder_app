import 'package:dio/dio.dart';

class MyInterceptor implements InterceptorsWrapper {
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(
      DioException(
        requestOptions: RequestOptions(path: err.requestOptions.path),
        error: err.response?.data.toString(),
      ),
    );
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    return handler.next(options);
  }

  @override
  // ignore: strict_raw_type
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
