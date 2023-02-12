import 'package:dio/dio.dart';

class MatchHelper {
  static var dio = Dio();

  //https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=f984863b10ca46d59631152aa6cc9377


  static Future<Response> getMatches ({
    required String url,
  }) async {
    return await dio.get(url);
  }
}