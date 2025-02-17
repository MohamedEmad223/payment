import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio();

  Future<Response> post(
      {required String url,
      required String body,
       String? token,
      String? contentType}) async {
    var response = await _dio.post(url,
        data: body,
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          'Authorization': 'Bearer $token',
        }));
    return response;
  }
}
