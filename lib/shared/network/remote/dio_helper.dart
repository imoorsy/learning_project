import 'package:dio/dio.dart';

class DioHelper {
  static var dio = Dio();

  //https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=f984863b10ca46d59631152aa6cc9377
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://v3.football.api-sports.io/',
        receiveDataWhenStatusError: true,
      ),
    );
  }


  static Future<Response> getData ({
    required String url,
    Map<String,dynamic>? query,
    String lang = 'ar',
    String? token,
}) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'lang' : lang,
      'Authorization' : token??'',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData ({
    required String url,
    required Map<String,dynamic> data,
    String lang = 'ar',
    String? token,
    Map<String,dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'lang' : lang,
      'Authorization' : token
    };
    return await dio.post(
        url,
        data: data,
        queryParameters: query
    );
  }

  static Future<Response> putData ({
    required String url,
    required String token,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String lang = 'ar',
  }) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'lang' : lang,
      'Authorization' : token
    };
    return await dio.put(
        url,
        data: data,
        queryParameters: query
    );
  }

  static Future<Response> getMatchData ({
    required String url,
    required Map<String,dynamic> query,
  }) async {
    dio.options.headers = {
      'x-apisports-key' : '7960e9f4b98ef571e7f0337519e747ff',
    };
    return await dio.get(url, queryParameters: query);
  }
}