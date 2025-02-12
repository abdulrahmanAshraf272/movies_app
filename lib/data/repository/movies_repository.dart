import 'package:movies_app/data/model/api_result.dart';
import 'package:movies_app/data/model/movie.dart';
import 'package:movies_app/data/web_services/movies_web_services.dart';

class MoviesRepository {
  final MoviesWebServices moviesWebServices;
  MoviesRepository(this.moviesWebServices);

  Future<ApiResult<List<Movie>>> getMovies(String genre) async {
    final apiResult = await moviesWebServices.getMovies(
        rating: 6.5, sortBy: "like_count", genre: genre);

    return apiResult.when(
      success: (rawMovies) {
        List<Movie> movies =
            rawMovies.map((movie) => Movie.fromJson(movie)).toList();
        return ApiResult.success(movies);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }
}
