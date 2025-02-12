import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/model/movie.dart';
import 'package:movies_app/data/repository/movies_repository.dart';
import 'package:movies_app/data/web_services/network_exceptions.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepository moviesRepository;
  final TextEditingController textEditingController = TextEditingController();
  List<Movie> allMovies = [];
  String genre = 'all';

  MoviesCubit(this.moviesRepository) : super(MoviesInitial());

  Future<void> getMovies() async {
    emit(MoviesLoading());

    final result = await moviesRepository.getMovies(genre);

    result.when(
      success: (movies) {
        allMovies = movies;
        emit(MoviesLoaded(movies));
      },
      failure: (error) =>
          emit(MoviesError(NetworkExceptions.getErrorMessage(error))),
    );
  }

  startSearch() {
    emit(MoviesLoaded(allMovies, isSearching: true));
  }

  stopSearch() {
    textEditingController.clear();
    emit(MoviesLoaded(allMovies, isSearching: false));
  }

  searchMovies(String query) {
    if (query.isEmpty) {
      emit(MoviesLoaded(allMovies, isSearching: true));
    } else {
      final filteredMovies = allMovies
          .where((movie) =>
              movie.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(MoviesLoaded(filteredMovies, isSearching: true));
    }
  }

  selectCategory(String category) {
    genre = category;
    getMovies();
  }
}
