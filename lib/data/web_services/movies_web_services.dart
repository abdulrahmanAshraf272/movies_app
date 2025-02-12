import 'package:dio/dio.dart';
import 'package:movies_app/constants/strings.dart';
import 'package:movies_app/data/model/api_result.dart';
import 'package:movies_app/data/web_services/network_exceptions.dart';

class MoviesWebServices {
  late Dio dio;

  MoviesWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
    dio.interceptors.add(LogInterceptor(
        request: true, requestBody: true, responseBody: true, error: true));
  }

  Future<ApiResult<List<dynamic>>> getMovies(
      {required num rating,
      required String sortBy,
      required String genre}) async {
    try {
      Response response = await dio.get('list_movies.json', queryParameters: {
        "minimum_rating": rating,
        "limit": 50,
        "sort_by": sortBy,
        "genre": genre
      });
      if (response.statusCode == 200 && response.data['data'] != null) {
        return ApiResult.success(response.data['data']['movies']);
      } else {
        return ApiResult.failure(NetworkExceptions.handleResponse(response));
      }
    } catch (error) {
      return ApiResult.failure(NetworkExceptions.getDioException(error));
    }
  }
}
