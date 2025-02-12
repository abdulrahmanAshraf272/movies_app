import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/data/model/movie.dart';
import 'package:movies_app/data/repository/movies_repository.dart';
import 'package:movies_app/data/web_services/network_exceptions.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepository moviesRepository;

  MoviesCubit(this.moviesRepository) : super(MoviesInitial());

  Future<void> getMovies() async {
    emit(MoviesLoading());

    final result = await moviesRepository.getMovies();

    result.when(
      success: (movies) => emit(MoviesLoaded(movies)),
      failure: (error) =>
          emit(MoviesError(NetworkExceptions.getErrorMessage(error))),
    );
  }
}
