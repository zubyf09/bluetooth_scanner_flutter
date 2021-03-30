import 'package:dio/dio.dart';

class NetworkProvider {
  String authorization;

  static Dio instance({String authorization, String contentType}) {
    final dio = Dio();
    //authorization=authorization;
    //  dio.options.contentType = contentType ?? Headers.formUrlEncodedContentType;
    dio.options.headers["language"] = "en";
    // dio.options.headers['Authorization'] = authorization;
    //  dio.options.headers['Content-Type']= contentType ?? "application/x-www-form-urlencoded";
    dio.options.headers['Accept'] = "application/json";
    return dio;
  }
}

class HttpLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    print("onRequest: ${options.uri}\n"
        "data=${options.data}\n"
        "method=${options.method}\n"
        "headers=${options.headers}\n"
        "queryParameters=${options.queryParameters}");
    return options;
  }

  @override
  Future onResponse(Response response) {
    print("onResponse: $response");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("onError: $err\n"
        "Response: ${err.response}");
    return super.onError(err);
  }
}

enum DioErrorType {
  /// When opening  url timeout, it occurs.
  CONNECT_TIMEOUT,

  ///It occurs when receiving timeout.
  RECEIVE_TIMEOUT,

  /// When the server response, but with a incorrect status, such as 404, 503...
  RESPONSE,

  /// When the request is cancelled, dio will throw a error with this type.
  CANCEL,

  /// Default error type, Some other Error. In this case, you can
  /// read the DioError.error if it is not null.
  DEFAULT,
}
